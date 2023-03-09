import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/widget_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor, foregroundColor: whiteColor),
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text(
                "Yes",
                style: TextStyle(fontFamily: bold),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor, foregroundColor: whiteColor),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(fontFamily: bold),
              )),
        ],
      )
    ],
  ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make());
}
