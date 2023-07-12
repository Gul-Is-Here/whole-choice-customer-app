import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? title,
    String? hint,
    Icon? icon,
    controller,
    isPass,
    validate,
    color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(fontGrey).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
          validator: validate,
          obscureText: isPass,
          cursorColor: fontGrey,
          controller: controller,
          decoration: InputDecoration(
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: whiteColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: whiteColor)),
            hintText: hint,
            isDense: true,
            fillColor: Colors.grey.shade200,
            filled: true,
            prefixIcon: icon,
            prefixIconColor: color,

            // border: InputBorder.none,
          )),
      5.heightBox
    ],
  );
}
