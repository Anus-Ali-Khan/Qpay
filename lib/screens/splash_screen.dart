import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/constants.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
    // required this.screen,
  }) : super(key: key);

  // Widget screen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(height: 10.0),
            Text(
              AppLocalizations.of(context)!.hassleFreeTransactions,
              style: const TextStyle(color: greyBackground),
            )
          ],
        ),
      ),
    );
  }
}
