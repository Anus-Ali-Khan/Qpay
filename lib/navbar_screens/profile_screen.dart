import 'package:flutter/material.dart';
import 'package:qr_code/services/auth_service.dart';

import '../screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  void handleSignOut() {
    authService.signOut();
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/images/logo.png"),
            ],
          )
        ],
      ),
    );
  }
}
