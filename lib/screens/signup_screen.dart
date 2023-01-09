import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/models/user_model.dart';
import 'package:qr_code/navbar_screens/navbar.dart';
import 'package:qr_code/screens/login_screen.dart';
import 'package:qr_code/services/auth_service.dart';
import 'package:qr_code/services/user_service.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  AuthService authService = AuthService();
  UserService userService = UserService();

  void handleLogin(BuildContext context) {
    if (nameController.text != "" && passwordController.text != "" && emailController.text != "" && phoneNumberController.text != "") {
      context.loaderOverlay.show();
      authService
          .signUpWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        if (value["success"]) {
          try {
            await authService.signInWithEmail(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            UserModel user = UserModel(
              userId: authService.getCurrentUser().uid,
              userName: nameController.text,
              email: emailController.text.trim(),
              phoneNumber: phoneNumberController.text,
              balanceAmount: 50000,
            );
            userService.createUser(user).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
              Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar(e.toString()));
          }
          context.loaderOverlay.hide();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar("Please fill out all the fields first"));
    }
  }

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
                  "Sign Up",
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
                    hintText: "user@email.com",
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

                const SizedBox(height: 20.0),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(color: white, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: "0315795768",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),

                const SizedBox(height: 60.0),

                Center(
                  child: CustomButton(
                    title: "Sign Up",
                    onPressed: () {
                      handleLogin(context);
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
                        "Already have an account?",
                        style: TextStyle(color: white, fontSize: 12.0),
                      ),
                      const SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          "Login",
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
