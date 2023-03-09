import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).center.make()
    ],
  )
      .box
      .white
      .shadowSm
      .rounded
      .width(width)
      .margin(const EdgeInsets.symmetric(horizontal: 5, vertical: 5))
      .height(60)
      .padding(const EdgeInsets.all(2))
      .make();
}
