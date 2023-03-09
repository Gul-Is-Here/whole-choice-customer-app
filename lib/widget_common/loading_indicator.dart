import 'package:flutter/material.dart';
import 'package:whole_choice_customer/consts/colors.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(yellowColor),
    ),
  );
}
