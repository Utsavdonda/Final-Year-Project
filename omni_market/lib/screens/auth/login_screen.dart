import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/controller/auth_controller.dart';
import 'package:omni_market/repository/auth/login_client.dart';
import 'package:omni_market/screens/auth/selection_screen.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController = AuthController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s30.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ScreenUtil().setVerticalSpacing(80),
                  SizedBox(
                      height: Sizes.s80.h,
                      child: Image.asset('assets/image/applogo1.png')),
                  ScreenUtil().setVerticalSpacing(20),
                  Text("Omni Market",
                      style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: Sizes.s30.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor)),
                  ScreenUtil().setVerticalSpacing(30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: Sizes.s28.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Please Sign in to continue",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: Sizes.s16.sp,
                        color: const Color(0xff726d81),
                      ),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  textview(
                      controller: email,
                      hintText: "EMAIL",
                      isPrefixWidget: true,
                      isEmailValidator: true,
                      needValidation: true,
                      prefix: const Icon(
                        Icons.email_outlined,
                      ),
                      context: context),
                  ScreenUtil().setVerticalSpacing(15),
                  Obx(
                    () => textview(
                      context: context,
                      controller: password,
                      isPasswordValidator: true,
                      needValidation: true,
                      hintText: "PASSWORD",
                      isPrefixWidget: true,
                      obscureText: authController.isPasswordHide.value,
                      isSuffixWidget: true,
                      suffix: authController.isPasswordHide.value
                          ? InkWell(
                              onTap: () {
                                authController.isPasswordHide.value =
                                    !authController.isPasswordHide.value;
                              },
                              child: const Icon(
                                Icons.visibility_off_outlined,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                authController.isPasswordHide.value =
                                    !authController.isPasswordHide.value;
                              },
                              child: const Icon(
                                Icons.visibility_outlined,
                              ),
                            ),
                      prefix: const Icon(
                        Icons.lock_outline,
                      ),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Forget Password?",
                        style: AppTextStyle.regularTextStyle.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: Sizes.s16.sp),
                      ),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(25),
                  AnimatedButtonView(
                      title: "Login",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await LoginClientImplementation().loginUser(context, {
                            "email": email.text,
                            "password": password.text,
                          });
                        } else {
                          const SnackBar(
                              content: Text(
                                  "Please enter valid email and password"));
                        }
                      }),
                  ScreenUtil().setVerticalSpacing(40),
                  InkWell(
                    onTap: () {
                      navigationPush(context, const SelectionScreen());
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyle.regularTextStyle.copyWith(
                              color: const Color(0xff726d81),
                              fontSize: Sizes.s16.sp),
                          children: [
                            TextSpan(
                              text: "Signup",
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: Sizes.s16.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
