import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../session.dart';
import 'config.dart';

class ArticleProvider extends ChangeNotifier {
  Future<dynamic> createarticle(String title, String body, String banner,
      String imageUrl, String categories) async {
    try {
      final url = Uri.parse(
          '${Config.SOCMED_END_POINT}web-forum-service/article/create');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
          },
          body: jsonEncode({
            'title': title,
            'body': body,
            'imageUrl': imageUrl,
            'banner': banner,
            'categories': [
              {"name": categories}
            ],
          }));

      print('${url} ${response.body}');

      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        return result;
      } else {
        print(result);
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }

  Future<dynamic> getlistarticle(
      int page, String title, String category) async {
    try {
      final url =
          Uri.parse('${Config.SOCMED_END_POINT}web-forum-service/article/list');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
          },
          body: jsonEncode({
            'page': page,
            'title': title,
            'category': category,
          }));

      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        return result;
      } else {
        return result;
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }

  Future<dynamic> getarticledetail(String id) async {
    try {
      final url = Uri.parse(
          '${Config.SOCMED_END_POINT}web-forum-service/article?id=$id');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
        },
      );
      print("object123");

      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        print("object");
        return result;
      } else {
        return result;
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }
}
