import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_code/models/transfer_money_model.dart';
import 'package:qr_code/models/user_model.dart';
import 'package:qr_code/providers/user_provider.dart';
import 'package:qr_code/services/transfer_money_service.dart';
import 'package:qr_code/services/user_service.dart';
import 'package:qr_code/widgets/custom_button.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

import '../widgets/custom_snackbar.dart';

class TransferMoneyScreen extends StatelessWidget {
  TransferMoneyScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TransferMoneyService transferMoneyService = TransferMoneyService();
  UserService userService = UserService();
  UserProvider? userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              AppLocalizations.of(context)!.transferMoney,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/transfermoney.jpg",
                  height: height * 0.25,
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.transferMoneyDescription,
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
                SizedBox(height: height * 0.3),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomButton(
                    title: AppLocalizations.of(context)!.transfer,
                    onPressed: () {
                      if (emailController.text != "" && amountController.text != "") {
                        context.loaderOverlay.show();
                        TransferMoneyModel transferMoneyModel = TransferMoneyModel(
                          senderId: userProvider!.user!.userId,
                          senderEmail: userProvider!.user!.email,
                          friendEmail: emailController.text,
                          amount: double.parse(amountController.text),
                          message: "${userProvider!.user!.email} sent money to ${emailController.text}",
                          timestamp: DateTime.now(),
                        );

                        transferMoneyService.transferMoney(transferMoneyModel).then((value) {
                          context.loaderOverlay.hide();
                          if (value["success"]) {
                            userService
                                .updateUserAmount(userProvider!.user!.userId, userProvider!.user!.balanceAmount - double.parse(amountController.text))
                                .whenComplete(() {
                              userService.getUserByEmail(emailController.text).then((value) {
                                print("User by email: ${value.docs.first.data()}");
                                userService.updateUserAmount(
                                  value.docs.first.data()["userId"],
                                  (value.docs.first.data()["balanceAmount"] as double) + double.parse(amountController.text),
                                );
                                // userService.updateUserAmount(receiver.userId, receiver.balanceAmount + double.parse(amountController.text));
                              });

                              userService.getUser(userProvider!.user!.userId).then((value) {
                                userProvider?.setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
                              });
                            });
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                          }
                          // emailController.text = "";
                          // amountController.text = "";
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

// userService.getUserByEmail(emailController.text).then((value) {
// print("User by email: ${value.docs.first.data()}");
// });
