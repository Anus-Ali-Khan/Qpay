import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/l10n/l10n.dart';
import 'package:qr_code/navbar_screens/navbar.dart';
import 'package:qr_code/providers/locale_provider.dart';
import 'package:qr_code/providers/user_provider.dart';
import 'package:qr_code/screens/login_screen.dart';
import 'package:qr_code/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      builder: (context, child) {
        LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          title: 'Q Pay',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: localeProvider.getLocale(),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          // home: StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return SplashScreen(screen: Navbar());
          //     } else {
          //       // return Navbar();
          //       return SplashScreen(screen: LoginScreen());
          //     }
          //   },
          // ),
        );
      },
      // child: MaterialApp(
      //   title: 'Q Pay',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      //   locale: Locale("en"),
      //   supportedLocales: L10n.all,
      //   localizationsDelegates: const [
      //     AppLocalizations.delegate,
      //     GlobalMaterialLocalizations.delegate,
      //     GlobalWidgetsLocalizations.delegate,
      //     GlobalCupertinoLocalizations.delegate,
      //   ],
      //   debugShowCheckedModeBanner: false,
      //   home: SplashScreen(),
      //   // home: StreamBuilder<User?>(
      //   //   stream: FirebaseAuth.instance.authStateChanges(),
      //   //   builder: (context, snapshot) {
      //   //     if (snapshot.hasData) {
      //   //       return SplashScreen(screen: Navbar());
      //   //     } else {
      //   //       // return Navbar();
      //   //       return SplashScreen(screen: LoginScreen());
      //   //     }
      //   //   },
      //   // ),
      // ),
    );
  }
}
