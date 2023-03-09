import 'package:firebase_auth/firebase_auth.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/views/home-screens/home.dart';
import 'package:whole_choice_customer/widget_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Creating a Function For Changing Screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // USing get X
      // Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 300,
              )),
          // Using Velocity_x
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(), 30.heightBox
          // Our App Splash Screen is Completed
        ],
      ),
    );
  }
}
