import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/navbar_screens/navbar.dart';
import 'package:qr_code/screens/login_screen.dart';

import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
    // required this.screen,
  }) : super(key: key);

  // Widget screen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbar()));
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(height: 10.0),
            const Text(
              "Hassle free transactions",
              style: TextStyle(color: greyBackground),
            )
          ],
        ),
      ),
    );
  }
}
