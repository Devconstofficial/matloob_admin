import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/utils/app_colors.dart';

void showCustomSnackbar(String title, String message, {Color backgroundColor = kRedColor, bool isRTL = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
    borderRadius: 8,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    messageText: Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Text(message, style: const TextStyle(color: Colors.white), textAlign: isRTL ? TextAlign.right : TextAlign.left),
    ),
    titleText: Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: isRTL ? TextAlign.right : TextAlign.left,
      ),
    ),
  );
}
