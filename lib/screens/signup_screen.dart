import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/screens/login_screen.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  "Username",
                  style: TextStyle(color: white, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  hintText: "John Doe",
                  controller: nameController,
                  icon: Icons.person_outline_outlined,
                ),
              ),

              const SizedBox(height: 20.0),

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
                  title: "Sign Up",
                  onPressed: () {},
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
    );
  }
}
