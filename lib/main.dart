import 'package:flutter/material.dart';
import 'package:metrodata_academy/pages/loginpage.dart';
import 'package:metrodata_academy/pages/registerpage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
    },
  ));
}
