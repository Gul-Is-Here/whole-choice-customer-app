import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? title, String? hint, Icon? icon, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(yellowColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
          obscureText: isPass,
          cursorColor: fontGrey,
          controller: controller,
          decoration: InputDecoration(
              hintStyle:
                  const TextStyle(fontFamily: semibold, color: textfieldGrey),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 1, color: whiteColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 1, color: whiteColor)),
              hintText: hint,
              isDense: true,
              fillColor: Colors.yellow.shade100,
              filled: true,
              prefixIcon: icon

              // border: InputBorder.none,
              )),
      5.heightBox
    ],
  );
}
