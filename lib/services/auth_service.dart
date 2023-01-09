import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  Future<Map<String, dynamic>> signInWithEmail({required email, required password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {"success": true, "message": "User have logged in successfully"};
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      return {"success": false, "message": e.message.toString()};
    }
  }

  Future<Map<String, dynamic>> signUpWithEmail({required email, required password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {"success": true, "message": "User have signed up successfully"};
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return {"success": false, "message": e.message.toString()};
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  User getCurrentUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user;
  }
}
