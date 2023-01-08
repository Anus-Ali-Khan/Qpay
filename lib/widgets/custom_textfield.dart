import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.obscureText,
  }) : super(key: key);

  TextEditingController controller;
  String hintText;
  IconData icon;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: blackColor,
          size: 25.0,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: greyTextFieldText,
          fontSize: 16.0,
        ),
        fillColor: greyBackground,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: greyTextFieldText),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyTextFieldText),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyTextFieldText),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
