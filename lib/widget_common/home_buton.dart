import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButton({width, height, icon, String? title, onpress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .rounded
      .white
      .size(width, height)
      .shadowSm
      .margin(const EdgeInsets.symmetric(horizontal: 4, vertical: 4))
      .make();
}
