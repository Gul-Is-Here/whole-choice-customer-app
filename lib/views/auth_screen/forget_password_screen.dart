import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';
import 'package:whole_choice_customer/widget_common/our_button.dart';

import '../../widget_common/custom_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  forgetPassword({email, context}) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      VxToast.show(context, msg: "Password Reset email send!");
    } on FirebaseAuthException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customTextField(
                controller: controller.emailController,
                hint: emailHint,
                title: email,
                icon: emailIcon,
                isPass: false),
            ourButton(
                Color: yellowColor,
                title: "Send Email",
                textColor: darkFontGrey,
                onpress: () async {
                  await forgetPassword(email: controller.emailController.text);
                })
          ],
        ),
      ),
    );
  }
}
