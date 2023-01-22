import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/transfer_money_model.dart';

class TransferMoneyService {
  Future<Map<String, dynamic>> transferMoney(TransferMoneyModel transferMoneyModel) async {
    try {
      await FirebaseFirestore.instance.collection("transfers").doc().set(transferMoneyModel.toJson());
      return {"success": true, "message": "Money Transferred successfully"};
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return {"success": false, "message": e.message.toString()};
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTransfers(String userId, String userEmail) async {
    QuerySnapshot<Map<String, dynamic>> transfersMade =
        await FirebaseFirestore.instance.collection("transfers").where("senderId", isEqualTo: userId).get();

    QuerySnapshot<Map<String, dynamic>> transfersReceived =
        await FirebaseFirestore.instance.collection("transfers").where("friendEmail", isEqualTo: userEmail).get();

    return [...transfersMade.docs, ...transfersReceived.docs];
  }
}
