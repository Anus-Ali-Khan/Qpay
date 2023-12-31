import 'package:cloud_firestore/cloud_firestore.dart';

class AskAFriendModel {
  String requesterId;
  String requesterEmail;
  String friendEmail;
  double amount;
  String message;
  DateTime timestamp;

  AskAFriendModel({
    required this.requesterId,
    required this.requesterEmail,
    required this.friendEmail,
    required this.amount,
    required this.message,
    required this.timestamp,
  });

  factory AskAFriendModel.fromJson(Map<String, dynamic> json) {
    return AskAFriendModel(
      requesterId: json["requesterId"] as String,
      requesterEmail: json["requesterEmail"] as String,
      friendEmail: json["friendEmail"] as String,
      amount: json["amount"] as double,
      message: json["message"] as String,
      timestamp: (json["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "requesterId": requesterId,
      "requesterEmail": requesterEmail,
      "friendEmail": friendEmail,
      "amount": amount,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
