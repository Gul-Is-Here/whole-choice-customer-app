import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/images.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

Widget applogoWidget() {
  return Image.asset(
    icAppLogo,
    filterQuality: FilterQuality.high,
    fit: BoxFit.fitWidth,
  )
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .color(whiteColor)
      .rounded
      .make();
}
