import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/image_path.dart';
import 'package:omni_market/repository/auth/otp_verify.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key, this.email, required this.verifyData});

  final String? email;
  final Map<String, dynamic> verifyData;
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(clipBehavior: Clip.none, children: [
                Image.asset(ImagePath.otp1),
                Positioned(
                    top: Sizes.s15.w,
                    left: Sizes.s10.w,
                    child: IconButton(
                        onPressed: () {
                          navigationPop(context);
                        },
                        icon: const Icon(Icons.arrow_back))),
                Positioned(right: 0, child: Image.asset(ImagePath.otp2)),
                Positioned(
                    top: Sizes.s130.h,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      ImagePath.otp3,
                    )),
                ScreenUtil().setVerticalSpacing(35),
              ]),
              ScreenUtil().setVerticalSpacing(80),
              Text(
                'OTP Verification',
                style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.blackColor,
                    fontSize: Sizes.s20.sp,
                    fontWeight: FontWeight.bold),
              ),
              ScreenUtil().setVerticalSpacing(10),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'We will send you a one time password on\nthis',
                        style: AppTextStyle.regularTextStyle.copyWith(
                          color: AppColors.blackColor,
                        )),
                    TextSpan(
                        text: ' Email address.',
                        style: AppTextStyle.regularTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
              ScreenUtil().setVerticalSpacing(15),
              Text(email ?? "Email",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  )),
              ScreenUtil().setVerticalSpacing(10),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  length: 6,
                  controller: otp,
                  animationCurve: Curves.bounceIn,
                  autofocus: true,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  defaultPinTheme: PinTheme(
                    height: Sizes.s48.h,
                    width: Sizes.s48.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.greyColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(3, 3)),
                        BoxShadow(
                            color: AppColors.blackColor.withOpacity(0),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1)),
                      ],
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Sizes.s10.r),
                    ),
                  ),
                ),
              ),
              ScreenUtil().setVerticalSpacing(25),
              AnimatedButtonView(
                title: 'Submit',
                onTap: () async {
                  await OtpVerificationImplementation().getOtp(
                    context,
                    data: {"otp": otp.text, "userData": verifyData},
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
