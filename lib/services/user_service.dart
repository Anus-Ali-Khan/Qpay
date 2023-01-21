import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/user_model.dart';

class UserService {
  Future<Map<String, dynamic>> createUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(user.userId).set(user.toJson());
      return {"success": true, "message": "User created successfully"};
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return {"success": false, "message": e.message.toString()};
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) async {
    return await FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  updateUserAmount(String userId, double newAmount) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).update({"balanceAmount": newAmount});
  }

  Future updateUserNameAndNumber(String userId, String newName, String newNumber) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      "userName": newName,
      "phoneNumber": newNumber,
    });
  }
}
