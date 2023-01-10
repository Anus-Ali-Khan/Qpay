import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              children: [
                Image.asset("assets/images/logo.png"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: secondaryColor,
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              "Inbox",
              style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(color: blackColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
