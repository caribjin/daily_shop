import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'AIzaSyAc7NzHZGf87a_msO7AyLzCpilww2qRspk';
const signUpEndpoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey';
const signInEndpoint = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;

  Auth() {
    _token = '';
    _expireDate = DateTime.now();
    _userId = '';
  }

  Future<http.Response> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse(signUpEndpoint),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    return response;
  }

  Future<http.Response> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(signInEndpoint),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    return response;
  }
}
