import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/payment_model.dart';
import '../navbar_screens/navbar.dart';
import '../providers/user_provider.dart';
import '../services/payment_service.dart';
import '../services/user_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';

class TransactionDetailsScreen extends StatelessWidget {
  TransactionDetailsScreen({Key? key}) : super(key: key);

  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  PaymentService paymentService = PaymentService();
  UserService userService = UserService();
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.transactionDetails,
                    style: const TextStyle(fontSize: 29.0, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      AppLocalizations.of(context)!.receiverEmail,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  CustomTextField(
                    hintText: "johndoe@gmail.com",
                    controller: receiverController,
                    icon: Icons.person_outline_outlined,
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      AppLocalizations.of(context)!.amountToPay,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  CustomTextField(hintText: "50.0", controller: amountController, icon: Icons.monetization_on_outlined),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      AppLocalizations.of(context)!.reasonForPayment,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.rentGroceries,
                    controller: reasonController,
                    icon: Icons.description_outlined,
                  ),
                  const SizedBox(height: 100.0),
                  CustomButton(
                    title: AppLocalizations.of(context)!.submit,
                    onPressed: () {
                      if (receiverController.text != "" && amountController.text != "" && reasonController.text != "") {
                        context.loaderOverlay.show();
                        PaymentModel paymentModel = PaymentModel(
                          receiverEmail: receiverController.text,
                          amount: double.parse(amountController.text),
                          reason: reasonController.text,
                          timestamp: DateTime.now(),
                          senderId: userProvider.user!.userId,
                        );
                        userService.updateUserAmount(
                          userProvider.user!.userId,
                          userProvider.user!.balanceAmount - double.parse(amountController.text),
                        );
                        paymentService.makePayment(paymentModel).then((value) {
                          context.loaderOverlay.hide();
                          if (value["success"]) {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbar()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(value["message"]));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar(AppLocalizations.of(context)!.fillAllFieldsFirst));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
