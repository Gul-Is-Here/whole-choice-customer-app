import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/cart_controller.dart';
import 'package:whole_choice_customer/views/cart_screen/payment_method.dart';
import 'package:whole_choice_customer/widget_common/custom_textfield.dart';

class ShippinDetails extends StatelessWidget {
  const ShippinDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: darkFontGrey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: whiteColor,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
            onPressed: () {
              // if (contoller.addressController.text.length < 10) {
              //   return VxToast.show(context, msg: "Adress lenght more then 10");
              // } else if (contoller.cityController.text.length < 3) {
              //   VxToast.show(context,
              //       msg: 'Enter valid City name',
              //       position: VxToastPosition.top);
              // } else if (contoller.stateController.text.length < 3) {
              //   return VxToast.show(context,
              //       msg: 'Enter valid State name',
              //       position: VxToastPosition.top);
              // } else if (contoller.countryController.text.length < 5) {
              //   return VxToast.show(context,
              //       msg: 'Enter valid country name',
              //       position: VxToastPosition.top);
              // } else if (contoller.postalCodeController.text.isEmpty) {
              //   return VxToast.show(context,
              //       msg: 'Enter Postal Code', position: VxToastPosition.top);
              // } else if (contoller.phoneNumberController.text.isEmpty) {
              //   return VxToast.show(context,
              //       msg: 'Enter valid Phone number',
              //       position: VxToastPosition.top);
              // }
              if (contoller.addressController.text.length > 10 &&
                  contoller.stateController.text.length > 3 &&
                  contoller.stateController.text.length > 3 &&
                  contoller.countryController.text.length > 5 &&
                  contoller.postalCodeController.text.isNotEmpty &&
                  contoller.phoneNumberController.text.isNotEmpty) {
                Get.to(() => const PaymentMethod());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            child: "Continue".text.fontFamily(semibold).size(16).make()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            customTextField(
                hint: "e.g chack no 547/e.b tehsil and distric vehari",
                isPass: false,
                title: "Address",
                controller: contoller.addressController),
            10.heightBox,
            customTextField(
                hint: "e.g Vehari",
                isPass: false,
                title: "City",
                controller: contoller.cityController),
            10.heightBox,
            customTextField(
                hint: "e.g Punjab",
                isPass: false,
                title: "State",
                controller: contoller.stateController),
            10.heightBox,
            customTextField(
                hint: "e.g pakistan",
                isPass: false,
                title: "Country",
                controller: contoller.countryController),
            10.heightBox,
            customTextField(
                hint: "e.g 61101",
                isPass: false,
                title: "Postal code",
                controller: contoller.postalCodeController),
            10.heightBox,
            customTextField(
                hint: "e.g (+92) 3110064957 ",
                isPass: false,
                title: "Phone no",
                controller: contoller.phoneNumberController),
          ]),
        ),
      ),
    );
  }
}
