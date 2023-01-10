import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../models/payment_model.dart';
import '../services/auth_service.dart';
import '../services/payment_service.dart';

class TransactionHistoryScreen extends StatefulWidget {
  TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<PaymentModel> transactions = [
    // PaymentModel(
    //     senderId: "user@email.com",
    //     amount: 523,
    //     receiverEmail: "receiverEmailreceiverEmailreceiverEmailreceiverEmail",
    //     reason: "reason",
    //     timestamp: DateTime.now()),
    // PaymentModel(senderId: "senderId", amount: 523, receiverEmail: "receiverEmail", reason: "reason", timestamp: DateTime.now()),
    // PaymentModel(senderId: "senderId", amount: 523, receiverEmail: "receiverEmail", reason: "reason", timestamp: DateTime.now()),
  ];

  PaymentService paymentService = PaymentService();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    paymentService.getUserPayments(authService.getCurrentUser().uid).then((value) {
      for (var e in value.docs) {
        // print("e: ${e.data()}");
        // setState(() {
        transactions.add(PaymentModel.fromJson(e.data()));
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Row(
                children: [
                  Image.asset("assets/images/logo.png"),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: secondaryColor,
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                "Transaction History",
                style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
            ),
            transactions.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text(
                        "No transactions",
                        style: TextStyle(color: blackColor),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      PaymentModel currentTransaction = transactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: greyBackground,
                            border: Border.all(color: greyTextFieldText),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "To: ${currentTransaction.receiverEmail}",
                                          style: const TextStyle(fontSize: 16.0),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          currentTransaction.reason,
                                          style: const TextStyle(fontSize: 14.0, color: greyTextFieldText),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    "Rs. ${currentTransaction.amount}",
                                    style: const TextStyle(color: Colors.green, fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Text(DateFormat("dd-MM-yyyy - kk:mm").format(currentTransaction.timestamp))
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
