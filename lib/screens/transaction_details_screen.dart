import 'package:flutter/material.dart';
import 'package:qr_code/widgets/custom_textfield.dart';

import '../widgets/custom_button.dart';

class TransactionDetailsScreen extends StatelessWidget {
  TransactionDetailsScreen({Key? key}) : super(key: key);

  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Transaction Details",
                style: TextStyle(fontSize: 29.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Receiver Email",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              CustomTextField(
                hintText: "johndoe@gmail.com",
                controller: receiverController,
                icon: Icons.person_outline_outlined,
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Amount to pay",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              CustomTextField(hintText: "50.0", controller: amountController, icon: Icons.monetization_on_outlined),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Reason for Payment",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              CustomTextField(hintText: "Rent, groceries, etc", controller: reasonController, icon: Icons.description_outlined),
              const SizedBox(height: 100.0),
              CustomButton(
                title: "Submit",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
