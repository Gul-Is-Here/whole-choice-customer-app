import 'package:flutter/services.dart';
import 'package:whole_choice_customer/consts/colors.dart';
import 'package:whole_choice_customer/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/strings.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51NCgmGA84ClYLg12G4kmhacSLXXdftGoMShB3c2a34OlYXHABx0V09keWN3lFuiDNqdlh2NbRph6lHpcISiCldNS004yiN9TYm';
  Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We Are using GetX thats why we are using GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          primaryColor: Colors.yellow.shade700,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: whiteColor),
              backgroundColor: yellowColor),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: const TextStyle(
                fontSize: 18,
                fontFamily: 'Raleway',
              ))),
      home: const SplashScreen(),
    );
  }
}
