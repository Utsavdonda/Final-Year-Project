import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';

void showToast({
  required message,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Color? textColor = AppColors.whiteColor,
  Color? backgroundColor = AppColors.primaryColor,
}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: gravity,
    textColor: textColor,
    backgroundColor: backgroundColor,
  );
}

void showSuccessSnackBar({required String? message}) {
  Get.rawSnackbar(
      margin: const EdgeInsets.all(12),
      backgroundColor: Colors.green,
      borderRadius: 10,
      messageText: Text(message ?? 'Something went wrong',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          )),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
      ));
}

void showErrorSnackBar({required String? message}) {
  Get.rawSnackbar(
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(12),
    backgroundColor: Colors.red,
    borderRadius: 10,
    messageText: Text(message ?? 'Something went wrong',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        )),
    icon: const Icon(
      Icons.info_outline,
      color: Colors.white,
    ),
  );
}
