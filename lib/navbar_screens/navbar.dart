import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/navbar_screens/inbox_screen.dart';
import 'package:qr_code/navbar_screens/home_screen.dart';
import 'package:qr_code/navbar_screens/profile_screen.dart';
import 'package:qr_code/navbar_screens/transaction_history_screen.dart';
import 'package:qr_code/screens/qr_screen.dart';
import '../constants/constants.dart';
import 'package:qr_code/providers/user_provider.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;

  List screens = [
    HomeScreen(),
    TransactionHistoryScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  UserProvider userProvider = UserProvider();
  UserService userService = UserService();
  AuthService authService = AuthService();
  //
  // Map<String, dynamic> sampleUser = {
  //   "balanceAmount": 56389.56,
  //   "email": "muzammil@gmail.com",
  //   "phoneNumber": "064319466",
  //   "userId": "7uF4xbavNSUUJ46xnmpP3nTeFwF2",
  //   "userName": "Muzammil Ali Khan"
  // };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.show();
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userService.getUser(authService.getCurrentUser().uid).then((value) {
        userProvider.setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
        context.loaderOverlay.hide();
      });
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: primaryColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: currentIndex == 0 ? secondaryColor : white,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.stacked_bar_chart,
                    color: currentIndex == 1 ? secondaryColor : white,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.chat,
                    color: currentIndex == 2 ? secondaryColor : white,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentIndex == 3 ? secondaryColor : white,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QRScreen()));
            },
            backgroundColor: secondaryColor,
            child: const Icon(Icons.qr_code_scanner),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: screens[currentIndex],
        ),
      ),
    );
  }
}
