class UserModel {
  String userId;
  String userName;
  String email;
  String phoneNumber;
  int balanceAmount;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.balanceAmount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"] as String,
      userName: json["userName"] as String,
      email: json["email"] as String,
      phoneNumber: json["phoneNumber"] as String,
      balanceAmount: json["balanceAmount"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "balanceAmount": balanceAmount,
    };
  }
}
