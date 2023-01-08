import 'package:flutter/material.dart';
import 'package:qr_code/screens/qr_screen.dart';

class ButtonFile extends StatelessWidget {
  const ButtonFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: Text("Click to scan"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QRScreen()));
            },
          ),
        ),
      ),
    );
  }
}
