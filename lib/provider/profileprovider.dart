import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../session.dart';
import 'config.dart';

class ProfileProvider extends ChangeNotifier {
  Future<dynamic> getprofile() async {
    try {
      final url =
          Uri.parse('${Config.SOCMED_END_POINT}auth-service/user/get-profile');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
        },
      );

      final result = json.decode(response.body);
      print(result);

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

  Future<dynamic> updateprofile(
      String email,
      String username,
      String jenisKelamin,
      String alamat,
      String tanggalLahir,
      String name,
      String profilePicture) async {
    try {
      final url = Uri.parse(
          '${Config.SOCMED_END_POINT}auth-service/user/update-profile');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
          },
          body: jsonEncode({
            "email": email,
            "username": username,
            "jenisKelamin": jenisKelamin,
            "alamat": alamat,
            "tanggalLahir": tanggalLahir,
            "name": name,
            "profilePicture": profilePicture,
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

  Future<dynamic> uploadprofileimage(File imagefile) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${Config.SOCMED_END_POINT}master-service/upload/image/profile-picture'));

      request.headers['Authorization'] =
          "Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}";

      request.files.add(http.MultipartFile(
          'image', imagefile.readAsBytes().asStream(), imagefile.lengthSync(),
          filename: 'image.jpg', contentType: MediaType('image', 'jpeg')));
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      final result = json.decode('${responseString}');

      if (response.statusCode == 200) {
        return result;
      } else {
        print(result["data"]);
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }
}
