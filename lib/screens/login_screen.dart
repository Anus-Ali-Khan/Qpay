import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/screens/signup_screen.dart';
import 'package:qr_code/services/auth_service.dart';
import 'package:qr_code/widgets/custom_snackbar.dart';

import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset("assets/images/logo.png", alignment: Alignment.topLeft),
                ),
                // const SizedBox(height: 100.0),
                const Text(
                  "Login",
                  style: TextStyle(color: white, fontSize: 52.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Text(
                    "Email",
                    style: TextStyle(color: white, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    hintText: "user@emailcom",
                    controller: emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 20.0),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Text(
                    "Password",
                    style: TextStyle(color: white, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    controller: passwordController,
                    obscureText: true,
                    hintText: "*****",
                    icon: Icons.lock_outline,
                  ),
                ),

                const SizedBox(height: 60.0),

                Center(
                  child: CustomButton(
                    title: "Login",
                    onPressed: () async {
                      context.loaderOverlay.show();
                      authService
                          .signInWithEmail(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                          .then((value) {
                        context.loaderOverlay.hide();
                        if (!value["success"]) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                        }
                      });
                    },
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: white, fontSize: 12.0),
                      ),
                      const SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: white, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),

                Align(alignment: Alignment.bottomLeft, child: Image.asset("assets/images/login.png"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  String title;
  Function() onPressed;
  double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: secondaryColor,
      minWidth: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        title,
        style: const TextStyle(color: white, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
