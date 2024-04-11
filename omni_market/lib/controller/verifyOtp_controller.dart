import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_market/repository/auth/otp_verify.dart';
import 'package:omni_market/utils/api_error.dart';

class VerifyOtpController extends GetxController {
  Future<void> addOtp(
    BuildContext context,
    String? addOtp,
  ) async {
    try {
      // show loader
      Either<ApiError, Map> response =
          await OtpVerificationImplementation().getOtp(context, data: addOtp);
      response.fold(
        (error) {},
        (data) async {
          print(data);
        },
      );
    } catch (e, stacktrace) {
      sendBugReport(error: e, stackTree: stacktrace);
      // hide loader
    }
  }
}
