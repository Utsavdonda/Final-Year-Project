import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/controller/auth_controller.dart';
import 'package:omni_market/controller/diamond_controler.dart';
import 'package:omni_market/repository/auth/add_user.dart';
import 'package:omni_market/screens/auth/login_screen.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/common/dropdown_button.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

// ignore: must_be_immutable
class RegestationScreen extends StatelessWidget {
  RegestationScreen({super.key, this.role});
  String? role;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController cpassword = TextEditingController();

  TextEditingController fullname = TextEditingController();

  AuthController authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> selectedDiamondCateogry1 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s30.w),
            child: SingleChildScrollView(
              child: Column(children: [
                ScreenUtil().setVerticalSpacing(35),
                Row(
                  children: [
                    SizedBox(
                        height: Sizes.s45.h,
                        child: Image.asset('assets/image/applogo1.png')),
                    width10,
                    Text("Omni Market",
                        style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: Sizes.s26.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor)),
                  ],
                ),
                ScreenUtil().setVerticalSpacing(25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Account ",
                    style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: Sizes.s20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please fill the input below here",
                    style: AppTextStyle.regularTextStyle.copyWith(
                        color: const Color(0xff726d81), fontSize: Sizes.s14.sp),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(25),
                textview(
                  context: context,
                  backgroundColor: AppColors.transparentColor,
                  controller: fullname,
                  textInputType: TextInputType.name,
                  hintText: "FULL NAME",
                  isPrefixWidget: true,
                  prefix: const Icon(
                    Icons.person_outline,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(12),
                textview(
                  backgroundColor: AppColors.transparentColor,
                  context: context,
                  controller: phone,
                  textInputType: TextInputType.phone,
                  hintText: "PHONE",
                  isPhoneNumberValidator: true,
                  needValidation: true,
                  isPrefixWidget: true,
                  prefix: const Icon(
                    Icons.phone_outlined,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(12),
                textview(
                  backgroundColor: AppColors.transparentColor,
                  context: context,
                  controller: email,
                  textInputType: TextInputType.emailAddress,
                  hintText: "EMAIL",
                  isEmailValidator: true,
                  needValidation: true,
                  isPrefixWidget: true,
                  prefix: const Icon(
                    Icons.email_outlined,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(12),
                Obx(
                  () => textview(
                    backgroundColor: AppColors.transparentColor,
                    context: context,
                    controller: password,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "PASSWORD",
                    isPasswordValidator: true,
                    needValidation: true,
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
                ScreenUtil().setVerticalSpacing(12),
                Obx(
                  () => textview(
                    backgroundColor: AppColors.transparentColor,
                    context: context,
                    controller: cpassword,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "CONFIRM PASSWORD",
                    isPrefixWidget: true,
                    obscureText: authController.isConfirmPasswordHide.value,
                    isSuffixWidget: true,
                    suffix: authController.isConfirmPasswordHide.value
                        ? InkWell(
                            onTap: () {
                              authController.isConfirmPasswordHide.value =
                                  !authController.isConfirmPasswordHide.value;
                            },
                            child: const Icon(
                              Icons.visibility_off_outlined,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              authController.isConfirmPasswordHide.value =
                                  !authController.isConfirmPasswordHide.value;
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
                ScreenUtil().setVerticalSpacing(12),
                role == "seller"
                    ? GetBuilder<DiamondController>(
                        init: DiamondController(),
                        builder: (controller) {
                          return buildMultiSelectDialogField(
                              context: context,
                              title: "Select Category",
                              buttonText: "Select Category",
                              items: controller
                                      .viewDiamondModel.data?[0].diamondName ??
                                  [],
                              selectedValues: selectedDiamondCateogry1,
                              onConfirm: (value) {
                                selectedDiamondCateogry1 = value;
                              });
                        })
                    : const SizedBox(
                        height: 0,
                      ),
                selectedDiamondCateogry1.isEmpty
                    ? ScreenUtil().setVerticalSpacing(35)
                    : ScreenUtil().setVerticalSpacing(5),
                AnimatedButtonView(
                    title: "Signup",
                    onTap: () async {
                      if (fullname.text.isEmpty ||
                          password.text != cpassword.text) {
                        Get.snackbar(
                            "FullName Or Password", "Something went wrong",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: AppColors.primaryColor,
                            colorText: AppColors.whiteColor);
                      } else {
                        if (_formKey.currentState?.validate() ?? false) {
                          FirebaseMessaging messaging =
                              FirebaseMessaging.instance;
                          String? fcmToken = await messaging.getToken();

                          if (role == "buyer") {
                            final data = {
                              "name": fullname.text,
                              "fcm_token": fcmToken,
                              "email": email.text,
                              "password": password.text,
                              "contact": phone.text,
                              "role": "buyer",
                            };
                            await AddUserImplementation().addUser(
                              context,
                              {"email": email.text},
                              data,
                            );
                          } else {
                            final data = {
                              "name": fullname.text,
                              "password": password.text,
                              "email": email.text,
                              "fcm_token": fcmToken,
                              "contact": phone.text,
                              "role": "seller",
                              "seller_category": selectedDiamondCateogry1,
                            };
                            await AddUserImplementation().addUser(
                              context,
                              {"email": email.text},
                              data,
                            );
                          }
                        }
                      }
                    }),
                selectedDiamondCateogry1.isEmpty
                    ? ScreenUtil().setVerticalSpacing(30)
                    : ScreenUtil().setVerticalSpacing(5),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      navigationPush(context, const LoginScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: AppTextStyle.regularTextStyle.copyWith(
                            color: const Color(0xff726d81),
                            fontSize: Sizes.s16.sp),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: Sizes.s16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
