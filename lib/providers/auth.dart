import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const apiKey = 'AIzaSyAc7NzHZGf87a_msO7AyLzCpilww2qRspk';

class Auth with ChangeNotifier {
  late String? _token;
  late DateTime? _expireDate;
  late String? _userId;

  Timer? _authTimer;

  Auth() {
    _token = null;
    _expireDate = null;
    _userId = null;
    _authTimer = null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _expireDate != null && _expireDate!.isAfter(DateTime.now())) {
      return _token!;
    }

    return null;
  }

  Future<http.Response> _authenticate(String email, String password, String urlSegment) async {
    final signUpEndpoint = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apiKey';

    final response = await http.post(
      Uri.parse(signUpEndpoint),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseJson = json.decode(response.body);

    _token = responseJson['idToken'];
    _expireDate = DateTime.now().add(Duration(seconds: int.parse(responseJson['expiresIn'])));
    _userId = responseJson['localId'];

    _autoLogout();

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth', json.encode(toJson()));

    return response;
  }

  Future<http.Response> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<http.Response> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('auth')) return false;

    final authData = json.decode(prefs.getString('auth')!) as Map<String, dynamic>;
    final expireDate = DateTime.parse(authData['expireDate']);

    if (expireDate.isBefore(DateTime.now())) return false;

    _token = authData['token'];
    _userId = authData['userId'];
    _expireDate = expireDate;

    notifyListeners();

    _autoLogout();

    return true;
  }

  Future<void> logOut() async {
    _token = null;
    _expireDate = null;
    _userId = null;

    _cancelTimer();

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _cancelTimer() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
  }

  void _autoLogout() {
    _cancelTimer();

    final timeToExpire = _expireDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logOut);
  }

  Map<String, dynamic> toJson() {
    return {
      'token': _token,
      'expireDate': _expireDate == null ? '' : _expireDate!.toIso8601String(),
      'userId': _userId
    };
  }
}
