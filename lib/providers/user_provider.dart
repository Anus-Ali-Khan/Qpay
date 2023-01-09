import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;

  setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }
}
