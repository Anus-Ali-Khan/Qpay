import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/services/auth_service.dart';
import 'package:qr_code/constants/constants.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../screens/login_screen.dart';
import '../services/user_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  AuthService authService = AuthService();
  UserProvider userProvider = UserProvider();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return LoaderOverlay(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: primaryColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    GestureDetector(
                      onTap: () {
                        authService.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: const Icon(
                        Icons.logout_outlined,
                        size: 30.0,
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: secondaryColor,
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "My Profile",
                  style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  "User Name",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  initialValue: userProvider.user!.userName,
                  hintText: "John Doe",
                  controller: nameController,
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  initialValue: userProvider.user!.phoneNumber,
                  hintText: "325431",
                  controller: phoneNumberController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 300.0),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                  title: 'Update Profile',
                  onPressed: () async {
                    context.loaderOverlay.show();

                    userService
                        .updateUserNameAndNumber(
                      userProvider.user!.userId,
                      nameController.text,
                      phoneNumberController.text,
                    )
                        .then((value) {
                      context.loaderOverlay.hide();
                      userService.getUser(userProvider.user!.userId).then((value) {
                        userProvider.setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
                      });
                      ScaffoldMessenger.of(context).showSnackBar(snackBar("Profile updated"));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
