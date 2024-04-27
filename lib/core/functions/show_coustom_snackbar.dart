import 'package:cuer_city/core/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

void showCustomSnackBar(
    {required String message,
    bool isError = false,
    String title = "Error",
    void Function(GetSnackBar)? onTap}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title,
    message,
    onTap: onTap,
    titleText: Text(title, style: const TextStyle(color: Colors.white)),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? const Color(0xffcf6679) : AppColor.mainColor,
  );
}
