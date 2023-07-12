import 'package:flutter/material.dart';

Widget builtButton(
  context, {
  String? title,
  onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
