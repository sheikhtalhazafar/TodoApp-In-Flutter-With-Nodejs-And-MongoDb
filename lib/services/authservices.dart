import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:todo_nodejs/model/usermodel.dart';

class AuthService {
  // final http.Client client = AuthClient();
  final storage = const FlutterSecureStorage();
  String? token;
  User? userData;

  Future<String> signup(
    String name,
    String email,
    String password,
    String imagePath,
  ) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.15:45702/newuser/register'),
      );

      // Add text fields
      request.fields['username'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Add image file if provided
      if (imagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', imagePath),
        );
      }

      // Send the request
      var streamedResponse = await request.send();
      var res = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) print(res.body);

      if (res.statusCode == 201 || res.statusCode == 200) {
        final body = json.decode(res.body);
        token = body['token'];
        await storage.write(key: 'auth_token', value: token);

        return 'success';
      }

      return 'failed';
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return 'failed';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('http://192.168.1.15:45702/newuser/login'),
        body: {'email': email, 'password': password},
      );
      final body = json.decode(res.body);
      print(body);
      if (res.statusCode == 201 || res.statusCode == 200) {
        token = body['token'];
        await storage.write(key: 'auth_token', value: token);
        final userJson = body['userDetails'];
        userData = User.fromJson(userJson);

        await storage.write(
          key: 'UserData',
          value: json.encode(userData!.toJson()),
        );
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
