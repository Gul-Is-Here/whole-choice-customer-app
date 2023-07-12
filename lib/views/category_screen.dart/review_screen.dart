import 'package:flutter/material.dart';
import 'package:whole_choice_customer/consts/consts.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 'No Review Avaible'.text.make(),
      ),
    );
  }
}
