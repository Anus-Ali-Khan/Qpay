import 'package:cloud_firestore/cloud_firestore.dart';

class TransferMoneyModel {
  String senderId;
  String senderEmail;
  String friendEmail;
  double amount;
  String message;
  DateTime timestamp;

  TransferMoneyModel({
    required this.senderId,
    required this.senderEmail,
    required this.friendEmail,
    required this.amount,
    required this.message,
    required this.timestamp,
  });

  factory TransferMoneyModel.fromJson(Map<String, dynamic> json) {
    return TransferMoneyModel(
      senderId: json["senderId"] as String,
      senderEmail: json["senderEmail"] as String,
      friendEmail: json["friendEmail"] as String,
      amount: json["amount"] as double,
      message: json["message"] as String,
      timestamp: (json["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "friendEmail": friendEmail,
      "amount": amount,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
