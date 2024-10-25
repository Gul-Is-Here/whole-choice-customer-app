import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';

import '../../widget_common/customeText.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({super.key});
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number"),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
            child: Column(
          children: [
            customTextFormField(
                controller: controller.phoneController,
                icon: const Icon(Icons.phone),
                title: 'Phone Number',
                valid: (val) {
                  if (val.isEmpty) {
                    return "Enter valid Phone Number";
                  } else {
                    return controller.storeUserData(
                        phone: controller.passwordController.text);
                  }
                }),
            ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    await controller.phoneNumber(context);
                    controller.storeUserData(
                      phone: controller.phoneController,
                    );
                    print(controller.phoneController);
                  }
                },
                child: const Text("Get OTP"))
          ],
        )),
      ),
    );
  }
}
