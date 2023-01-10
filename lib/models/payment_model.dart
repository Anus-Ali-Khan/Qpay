import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String senderId;
  int amount;
  String receiverEmail;
  String reason;
  DateTime timestamp;

  PaymentModel({
    required this.senderId,
    required this.amount,
    required this.receiverEmail,
    required this.reason,
    required this.timestamp,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      senderId: json["senderId"] as String,
      amount: json["amount"] as int,
      receiverEmail: json["receiverEmail"] as String,
      reason: json["reason"] as String,
      timestamp: (json["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "amount": amount,
      "receiverEmail": receiverEmail,
      "reason": reason,
      "timestamp": timestamp,
    };
  }
}
