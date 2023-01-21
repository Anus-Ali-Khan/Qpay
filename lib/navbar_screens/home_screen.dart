import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/constants.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Map<String, String>> list = [
    {"title": "Deposit", "image": "assets/images/deposit.png"},
    {"title": "Transfer", "image": "assets/images/exchange.png"},
    {"title": "Withdraw", "image": "assets/images/withdraw.png"}
  ];

  List<String> promotionalImages = [
    "assets/images/promotion1.jpg",
    "assets/images/promotion2.png",
    "assets/images/promotion3.jpg",
    "assets/images/promotion4.jpg",
  ];

  AuthService authService = AuthService();
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/logo.png"),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.helloWorld,
                                  // "Hello",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  userProvider.user?.userName ?? "",
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Image.asset("assets/images/scan1.png"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 220.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: primaryColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: white),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Account Balance",
                                style: TextStyle(color: white, fontWeight: FontWeight.w500, fontSize: 17.0),
                              ),
                              Text(
                                "Rs. ${userProvider.user?.balanceAmount ?? ""}",
                                style: const TextStyle(color: white, fontWeight: FontWeight.w800, fontSize: 29.0),
                              ),
                              const SizedBox(height: 10.0),
                              const Divider(color: white),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: list.map((item) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        child: Image.asset(item["image"].toString()),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        item["title"].toString(),
                                        style: const TextStyle(color: white, fontSize: 10.0, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        // Image.asset("assets/images/promos-icon.png", height: 20.0),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20.0)),
                          child: const Icon(
                            Icons.percent,
                            size: 12.0,
                            color: white,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        const Text(
                          "Promotions",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: SizedBox(
                      height: 120.0,
                      child: ListView.builder(
                        itemCount: promotionalImages.length,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String currentItem = promotionalImages[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(image: AssetImage(currentItem), fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        // Image.asset("assets/images/promos-icon.png", height: 20.0),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20.0)),
                          child: const Icon(
                            Icons.real_estate_agent_outlined,
                            size: 12.0,
                            color: white,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        const Text(
                          "Rewards",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: SizedBox(
                      height: 120.0,
                      child: ListView.builder(
                        itemCount: promotionalImages.length,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String currentItem = promotionalImages[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(image: AssetImage(currentItem), fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
