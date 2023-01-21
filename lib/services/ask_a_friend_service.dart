import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/ask_a_friend_model.dart';

class AskAFriendService {
  Future<Map<String, dynamic>> requestFriend(AskAFriendModel askAFriendModel) async {
    try {
      await FirebaseFirestore.instance.collection("requests").doc().set(askAFriendModel.toJson());
      return {"success": true, "message": "Request made successfully"};
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return {"success": false, "message": e.message.toString()};
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRequests(String userId) async {
    return await FirebaseFirestore.instance.collection("requests").where("requesterId", isEqualTo: userId).get();
    // return await FirebaseFirestore.instance.collection("requests").where("requesterId", isEqualTo: userId).orderBy("timestamp", descending: true).get();
  }
}
