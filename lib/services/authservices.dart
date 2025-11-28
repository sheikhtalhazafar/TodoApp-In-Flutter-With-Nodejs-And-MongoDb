import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService {
  // final http.Client client = AuthClient();
  final storage = const FlutterSecureStorage();
  String? token;

  Future<String> signup(String name, String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('http://192.168.1.36:45702/newuser/register'),
        body: {'username': name, 'email': email, 'password': password},
      );

      final body = json.decode(res.body);
      print(body);
      if (res.statusCode == 201 || res.statusCode == 200) {
        token = body['token'];
        await storage.write(key: 'auth_token', value: token);
        return 'success';
      }
      return 'failed';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return 'failed';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('http://192.168.1.36:45702/newuser/login'),
        body: {'email': email, 'password': password},
      );
      final body = json.decode(res.body);
      print(body);
      if (res.statusCode == 201 || res.statusCode == 200) {
        token = body['token'];
        await storage.write(key: 'auth_token', value: token);
        return 'success';
      }
      return 'failed';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return 'failed';
    }
  }
}
