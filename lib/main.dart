import 'package:flutter/material.dart';
import 'package:qr_code/navbar_screens/navbar.dart';
import 'package:qr_code/screens/button_file.dart';
import 'package:qr_code/screens/qr_screen.dart';
import 'package:qr_code/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
