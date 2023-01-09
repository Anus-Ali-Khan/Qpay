import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/payment_model.dart';

class PaymentService {
  Future<Map<String, dynamic>> makePayment(PaymentModel paymentModel) async {
    try {
      await FirebaseFirestore.instance.collection("payments").doc().set(paymentModel.toJson());
      return {"success": true, "message": "Payment made successfully"};
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return {"success": false, "message": e.message.toString()};
    }
  }
}
