import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/models/ask_a_friend_model.dart';
import 'package:qr_code/providers/user_provider.dart';
import 'package:qr_code/services/ask_a_friend_service.dart';
import 'package:qr_code/widgets/custom_button.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

import '../widgets/custom_snackbar.dart';

class AskMoneyScreen extends StatelessWidget {
  AskMoneyScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  UserProvider? userProvider;
  AskAFriendService askAFriendService = AskAFriendService();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              AppLocalizations.of(context)!.askAFriend,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/givemoney.png",
                  height: height * 0.3,
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.askAFriendDescription,
                    style: const TextStyle(color: greyTextFieldText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: CustomTextField(
                    hintText: AppLocalizations.of(context)!.enterFriendEmail,
                    controller: emailController,
                    icon: Icons.mail_outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: CustomTextField(
                    hintText: AppLocalizations.of(context)!.amount,
                    controller: amountController,
                    icon: Icons.monetization_on_outlined,
                  ),
                ),
                SizedBox(height: height * 0.25),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomButton(
                    title: AppLocalizations.of(context)!.sendRequest,
                    onPressed: () {
                      if (emailController.text != "" && amountController.text != "") {
                        context.loaderOverlay.show();
                        AskAFriendModel askAFriendModel = AskAFriendModel(
                          requesterId: userProvider!.user!.userId,
                          requesterEmail: userProvider!.user!.email,
                          friendEmail: emailController.text,
                          amount: double.parse(amountController.text),
                          message: "${userProvider!.user!.email} asked you to send some money",
                          timestamp: DateTime.now(),
                        );

                        askAFriendService.requestFriend(askAFriendModel).then((value) {
                          context.loaderOverlay.hide();
                          if (value["success"]) {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                          }
                          emailController.text = "";
                          amountController.text = "";
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar(AppLocalizations.of(context)!.fillAllFieldsFirst));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
