import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_nodejs/model/notemodel.dart';
import 'package:todo_nodejs/services/auth_client.dart';

class Apiservices {
  final http.Client client = AuthClient();

  Future<String> postNotes(NoteModel note) async {
    try {
      var response = await client.post(
        Uri.parse('http://192.168.1.15:45702/api/add_notes'),
        body: jsonEncode(note.toJson()),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success: ${response.body}");
        }
        return "success";
      } else {
        if (kDebugMode) {
          print("Failed: ${response.statusCode}");
        }
        return "Failed";
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<List<NoteModel>> fetchallNOtes() async {
    try {
      var response = await client.get(
        Uri.parse('http://192.168.1.15:45702/api/get_notes'),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success: ${response.body}");
        }
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List data = decoded['data'];
        return data.map((e) => NoteModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Something went wrong : $e');
    }
  }

  Future<String> deleteNOte(NoteModel idIs) async {
    try {
      String id = idIs.id.toString();
      var response = await client.post(
        Uri.parse('http://192.168.1.15:45702/api/delete_notes/$id'),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success: ${response.body}");
        }
        return 'deleted';
      } else {
        return 'Failed';
      }
    } catch (e) {
      throw Exception('Something went wrong : $e');
    }
  }

   Future<String> updateNotes(NoteModel note) async {
    try {
      String id = note.id.toString();
      print(id);
      var response = await client.post(
        Uri.parse('http://192.168.1.15:45702/api/update_notes/$id'),
        body: jsonEncode(note.toJson()),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success: ${response.body}");
        }
        return "success";
      } else {
        if (kDebugMode) {
          print("Failed: ${response.statusCode}");
        }
        return "Failed";
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}
