import 'package:flutter/material.dart';

class TextField_widget extends StatelessWidget {
  String text;
  TextEditingController controller;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIcon;

  TextField_widget(
      {super.key,
      required this.text,
      required this.controller,
      this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        return FocusScope.of(context).requestFocus(focusNode);
      },
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
          filled: true,
          hintText: text,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          label: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
