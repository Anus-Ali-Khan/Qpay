import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';

SnackBar snackBar(String content) {
  return SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: blackColor),
    ),
    backgroundColor: greyBackground,
  );
}
