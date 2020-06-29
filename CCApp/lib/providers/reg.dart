import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CCApp/utils/http_exception.dart';

class Reg with ChangeNotifier {
  String _token;
  String _email;
  Map _userDetails = {};

  String get token {
    return _token;
  }

  String get email {
    return _email;
  }

  Map get userDetails {
    return _userDetails;
  }

  bool get isReg {
    return token != null;
  }

  Future<void> login(Map<String, String> data) async {
    final url = 'https://codechef-vit-app.herokuapp.com/Accounts/login/';
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        _token = 'Token ' + resBody["token"];
        final prefs = await SharedPreferences.getInstance();
        final _prefsData = jsonEncode({'token': _token, 'email': _email});
        await prefs.setString('userData', _prefsData);
        notifyListeners();
      } else {
        throw HttpException('Login Failed');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(Map<String, String> data) async {
    final url = 'https://codechef-vit-app.herokuapp.com/Accounts/register/';
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        final resBody = json.decode(response.body);
        _token = 'Token ' + resBody["token"];
        _userDetails['name'] = resBody["name"];
        _userDetails['email'] = resBody["email"];
        _userDetails['regno'] = resBody["regno"];
        print(_userDetails);
        final prefs = await SharedPreferences.getInstance();
        final _prefsData = jsonEncode({'token': _token, 'email': _email});
        await prefs.setString('userData', _prefsData);
        notifyListeners();
      } else {
        throw HttpException('Signup Failed');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _email = extractedUserData['email'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _email = null;
    notifyListeners();
  }
}
