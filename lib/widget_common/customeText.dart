import "package:flutter/material.dart";

Widget customTextFormField({String? title, controller, valid, Icon? icon}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: TextFormField(
      controller: controller,
      validator: valid,
      decoration: InputDecoration(prefixIcon: icon, label: Text(title!)),
    ),
  );
}
