import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_code/models/transfer_money_model.dart';
import 'package:qr_code/providers/user_provider.dart';
import 'package:qr_code/services/ask_a_friend_service.dart';
import 'package:qr_code/services/transfer_money_service.dart';

import '../models/ask_a_friend_model.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  AskAFriendService askAFriendService = AskAFriendService();
  TransferMoneyService transferMoneyService = TransferMoneyService();
  UserProvider userProvider = UserProvider();

  List<AskAFriendModel> requests = [];
  List<TransferMoneyModel> transfers = [];
  List requestsAndTransfers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      askAFriendService.getRequests(userProvider.user!.userId, userProvider.user!.email).then((value) {
        for (var e in value) {
          requests.add(AskAFriendModel.fromJson(e.data()));
        }
        setState(() {});
      });
      transferMoneyService.getTransfers(userProvider.user!.userId, userProvider.user!.email).then((value) {
        for (var e in value) {
          transfers.add(TransferMoneyModel.fromJson(e.data()));
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    requestsAndTransfers = [...transfers, ...requests];
    requestsAndTransfers.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Text(
                AppLocalizations.of(context)!.inbox,
                style: const TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
            ),
            if (requestsAndTransfers.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noNotifications,
                    style: const TextStyle(color: blackColor),
                  ),
                ),
              )
            else
              ListView.builder(
                  itemCount: requestsAndTransfers.length,
                  // itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.notification_important_outlined,
                                color: primaryColor,
                                size: 30.0,
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      requestsAndTransfers[index].message,
                                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.amount}: ${requestsAndTransfers[index].amount}",
                                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                        ),
                                        Text(DateFormat("dd-MM-yyyy - kk:mm").format(requestsAndTransfers[index].timestamp))
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }
}
