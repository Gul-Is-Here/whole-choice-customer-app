import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../widget_common/customeText.dart';
import '../../widget_common/rounded_buton.dart';

class VerifyPhoneNumber extends StatelessWidget {
  final String verificationId;
  VerifyPhoneNumber({required this.verificationId, super.key});
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
            child: Column(
          children: [
            customTextFormField(
                controller: controller.verifyController,
                icon: const Icon(Icons.phone),
                title: 'Enter OTP',
                valid: (val) {
                  if (val.isEmpty) {
                    return "Enter valid Phone Number";
                  } else {
                    return null;
                  }
                }),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    controller.verifyPhoneNumber(verificationId, context);
                  }
                },
                child: Text('Verify'))
          ],
        )),
      ),
    );
  }
}
