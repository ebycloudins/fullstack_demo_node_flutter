import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://ip:3000"; // replace with your IP

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

   Future<void> removeTask(String title) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add task");
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