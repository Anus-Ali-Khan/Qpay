import 'package:flutter/material.dart';
import 'package:qr_code/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.signOut();
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
