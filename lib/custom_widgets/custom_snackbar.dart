
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/utils/app_colors.dart';

void showCustomSnackbar(
  String title,
  String message, {
  Color backgroundColor = kRedColor,
}) {
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
  );
}