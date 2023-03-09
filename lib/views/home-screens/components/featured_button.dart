import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:whole_choice_customer/views/category_screen.dart/category_detail.dart';

import '../../category_screen.dart/category_screen.dart';

Widget featuredButton({String? title, icon}) {
  return Card(
    child: Row(
      children: [
        Image.asset(
          icon,
          width: 60,
          fit: BoxFit.fill,
        ),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    )
        .box
        .width(200)
        .margin(const EdgeInsets.symmetric(horizontal: 4))
        .white
        .padding(const EdgeInsets.all(4))
        .roundedSM
        .make()
        .onTap(() {
      Get.to(() => CategoriesDetail(title: title));
    }),
  );
}
