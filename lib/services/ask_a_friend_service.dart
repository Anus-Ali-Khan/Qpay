import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/ask_a_friend_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getRequests(String userId, String userEmail) async {
    QuerySnapshot<Map<String, dynamic>> requestsMade =
        await FirebaseFirestore.instance.collection("requests").where("requesterId", isEqualTo: userId).get();

    QuerySnapshot<Map<String, dynamic>> requestsReceived =
        await FirebaseFirestore.instance.collection("requests").where("friendEmail", isEqualTo: userEmail).get();

    return [...requestsMade.docs, ...requestsReceived.docs];
  }
}
