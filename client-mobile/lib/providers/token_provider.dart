import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

class TokenProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _token;
  Map<String, dynamic>? _decodedToken;
  String? _userName;
  User? _userData;

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> getToken() async {
    _token = await _secureStorage.read(key: 'token');
    notifyListeners();
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'token');
    _token = null;
    _decodedToken = null;
    notifyListeners();
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Map<String, dynamic> parseJwtHeader(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[0]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Future<dynamic> decodeToken() async {
    await getToken();
    if (_token != null) {
      _decodedToken = parseJwtPayLoad(_token!);
    }

    notifyListeners();
  }

  Future<void> saveUserData(User userData) async {
    Map<String, dynamic> userDataMap = {
      'id': userData.id,
      'name': userData.name,
      'email': userData.email,
      'number': userData.number,
      'img': userData.img,
      'isVerified': userData.isVerified,
      'role': userData.role,
    };

    String userDataString = json.encode(userDataMap);
    await _secureStorage.write(key: 'userData', value: userDataString);
  }

  Future<void> saveUnverfiedUserData(String email) async {
    Map<String, dynamic> userDataMap = {
      'email': email,
      'isVerified': false,
    };

    String userDataString = json.encode(userDataMap);
    await _secureStorage.write(key: 'userData', value: userDataString);
  }

  Future<void> getUserData() async {
    try {
      String? userDataString = await _secureStorage.read(key: 'userData');
      if (userDataString != null && userDataString.isNotEmpty) {
        _userData = User.fromMap(json.decode(userDataString));
        notifyListeners();
      }
    } catch (e) {
      print('Error decoding user data: $e');
    }
  }

  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: 'userData');
    _userData = null;
    notifyListeners();
  }

  Future<void> clearSecureStorage() async {
    await _secureStorage.deleteAll();
    _token = null;
    _decodedToken = null;
    _userData = null;
    notifyListeners();
  }

  Future<void> saveUserName(String userName) async {
    await _secureStorage.write(key: 'userName', value: userName);
  }

  Future<void> getUserName() async {
    _userName = await _secureStorage.read(key: 'userName');
    print(_userName);
    notifyListeners();
  }

  Future<void> deleteUserName() async {
    await _secureStorage.delete(key: 'userName');
    _userName = null;
    notifyListeners();
  }

  String get token => _token!;
  Map<String, dynamic>? get decodedToken => _decodedToken!;
  String get userName => _userName!;
  User? get userData => _userData!;
}
