import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'AIzaSyAc7NzHZGf87a_msO7AyLzCpilww2qRspk';

class Auth with ChangeNotifier {
  late String? _token;
  late DateTime? _expireDate;
  late String? _userId;

  Auth() {
    _token = null;
    _expireDate = null;
    _userId = null;
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

    notifyListeners();

    return response;
  }

  Future<http.Response> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<http.Response> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logOut() {
    _token = null;
    _expireDate = null;
    _userId = null;

    notifyListeners();
  }
}
