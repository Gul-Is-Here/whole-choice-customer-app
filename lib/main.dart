import 'package:whole_choice_customer/consts/colors.dart';
import 'package:whole_choice_customer/consts/styles.dart';
import 'package:whole_choice_customer/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: yellowColor),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
