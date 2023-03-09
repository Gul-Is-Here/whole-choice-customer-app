import 'package:whole_choice_customer/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({onpress, Color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color,
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onpress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
