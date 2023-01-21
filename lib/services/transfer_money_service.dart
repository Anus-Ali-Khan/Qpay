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

  Future<QuerySnapshot<Map<String, dynamic>>> getTransfers(String userId) async {
    return await FirebaseFirestore.instance.collection("transfers").where("senderId", isEqualTo: userId).get();
    // return await FirebaseFirestore.instance.collection("requests").where("requesterId", isEqualTo: userId).orderBy("timestamp", descending: true).get();
  }
}
