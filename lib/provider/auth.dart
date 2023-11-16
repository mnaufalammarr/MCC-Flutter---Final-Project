import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../session.dart';
import 'config.dart';

class AuthProvider extends ChangeNotifier {
  Future<dynamic> register(String email, String username, String jenisKelamin,
      String tanggalLahir, String password, String name) async {
    try {
      final url =
          Uri.parse('${Config.SOCMED_END_POINT}auth-service/auth/register');
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

  Future<dynamic> login(String email, String password) async {
    final url = Uri.parse('${Config.SOCMED_END_POINT}auth-service/auth/login');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emailorusername': email, 'password': password}));

    print('${url} ${response.body}');

    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result["message"] == "Success") {
        // await Session.set(Session.USERID_SESSION_KEY, email);
        await Session.set(Session.TOKEN_SESSION_KEY, result['data']['token']);
        // await Session.set(Session.PASSWD_KEY, password);
        return result;
      }
    }
    return result;
  }
}
