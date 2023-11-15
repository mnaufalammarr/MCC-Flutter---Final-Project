import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class AuthProvider extends ChangeNotifier {
  Future<dynamic> register(String email, String username, String jenisKelamin,
      String tanggalLahir, String password, String name) async {
    try {
      final url = Uri.parse(
          "http://34.125.215.71:8080/api/v1/auth-service/auth/register");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "username": username,
          "jenisKelamin": jenisKelamin,
          "tanggalLahir": tanggalLahir,
          "password": password,
          "name": name,
        }),
      );

      print("${response.statusCode} ${response.body}");

      final result = json.decode(response.body);

      if (response.statusCode == 201) {
        return result;
      } else {
        print("Error Register: ${result}");
        return result;
      }
    } catch (e) {
      print("Error Register: ${e}");
      return e;
    }
  }
}
