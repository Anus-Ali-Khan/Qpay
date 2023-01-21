import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_code/widgets/custom_button.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

class TransferMoneyScreen extends StatelessWidget {
  TransferMoneyScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
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
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
