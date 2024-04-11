import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';

class AppTextStyle {
  static TextStyle mediumTextStyle = TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "poppins-bold",
    color: AppColors.whiteColor,
    letterSpacing: 0,
  );

  static TextStyle regularTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
    fontFamily: "poppins",
    letterSpacing: 0,
  );

  static TextStyle smallTextStyle = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteColor,
    letterSpacing: 0,
    fontFamily: "poppins",
  );
}
