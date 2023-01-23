import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/providers/locale_provider.dart';
import 'package:qr_code/services/auth_service.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../screens/login_screen.dart';
import '../services/user_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  AuthService authService = AuthService();
  UserService userService = UserService();

  UserProvider userProvider = UserProvider();
  LocaleProvider localeProvider = LocaleProvider();

  Locale? selectedLanguageLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      setState(() {
        selectedLanguageLocale = localeProvider.getLocale();
      });
    });
  }

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
                        userProvider.deleteUser();
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.myProfile,
                      style: const TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.w600),
                    ),
                    DropdownButton<Locale>(
                      value: selectedLanguageLocale,
                      style: const TextStyle(color: white),
                      iconEnabledColor: white,
                      dropdownColor: primaryColor,
                      items: const [
                        DropdownMenuItem(value: Locale("en"), child: Text("English")),
                        DropdownMenuItem(value: Locale("es"), child: Text("Spanish")),
                        DropdownMenuItem(
                          value: Locale.fromSubtags(languageCode: "ur", countryCode: "PK"),
                          child: Text("Urdu"),
                        ),
                      ],
                      onChanged: (Locale? locale) {
                        localeProvider.setLocale(locale!);
                        setState(() {
                          selectedLanguageLocale = locale;
                        });
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.userName,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  initialValue: userProvider.user?.userName,
                  hintText: "John Doe",
                  controller: nameController,
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  initialValue: userProvider.user?.phoneNumber,
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
                  title: AppLocalizations.of(context)!.updateProfile,
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar(AppLocalizations.of(context)!.profileUpdated));
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
