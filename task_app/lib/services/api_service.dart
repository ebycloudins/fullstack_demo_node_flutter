import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/utils/constants.dart';

class ApiService {
  final String baseUrl = "http://$LOCAL_IP:3000";

  Future<List<dynamic>> getTasks() async {
    final response = await http.get(
      Uri.parse("$baseUrl/tasks"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  Future<void> deleteTask(String id) async {
  final response = await http.delete(
    Uri.parse("$baseUrl/tasks/$id"),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to delete task");
  }else {
   print("Deleted success");
  }
}

Future<void> updateTask(String id, String newTitle) async {
  final response = await http.put(
    Uri.parse("$baseUrl/tasks/$id"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"title": newTitle}),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to update task");
  }else{
    print("Updated success");
  }
}

  Future<void> addTask(String title) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add task");
    }
  }
}