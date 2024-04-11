import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/diamond_controler.dart';
import 'package:omni_market/controller/user_controller.dart';
import 'package:omni_market/repository/auth/update_profile.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/dropdown_button.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: LocalStorage.sharedPreferences.getString(LocalStorage.name) ??
              'User Name',
          isBackIcon: true,
          backIconPress: () {
            Navigator.pop(context);
          },
          elevation: 0),
      body: GetBuilder<UserController>(
          init: UserController(),
          builder: (userController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s16.sp),
              child: Column(
                children: [
                  ScreenUtil().setVerticalSpacing(20),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Select Image"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Camera"),
                                onTap: () {
                                  userController.pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text("Gallery"),
                                onTap: () {
                                  userController.pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(Sizes.s70.r),
                            child: Container(
                              height: Sizes.s130.h,
                              width: Sizes.s140.w,
                              color: Colors.grey,
                              child: LocalStorage.sharedPreferences
                                          .getString(LocalStorage.profile) !=
                                      null
                                  ? Image.network(LocalStorage.sharedPreferences
                                      .getString(LocalStorage.profile)
                                      .toString())
                                  : Icon(
                                      Icons.camera_alt,
                                      size: Sizes.s40.sp,
                                      color: Colors.white,
                                    ),
                            ))),
                  ),
                  ScreenUtil().setVerticalSpacing(20),
                  textview(
                    context: context,
                    controller: userController.nameController,
                  ),
                  ScreenUtil().setVerticalSpacing(20),
                  textview(
                      context: context,
                      controller: userController.emailController,
                      enabled: true),
                  ScreenUtil().setVerticalSpacing(20),
                  textview(
                      context: context,
                      controller: userController.phoneController),
                  ScreenUtil().setVerticalSpacing(20),
                  LocalStorage.sharedPreferences.getString(LocalStorage.role) ==
                          "seller"
                      ? GetBuilder<DiamondController>(
                          init: DiamondController(),
                          builder: (controller) {
                            return buildMultiSelectDialogField(
                                context: context,
                                title: "Select Category",
                                buttonText: "Select Category",
                                items: controller.viewDiamondModel.data?[0]
                                        .diamondName ??
                                    [],
                                selectedValues: LocalStorage.sharedPreferences
                                        .getStringList(
                                            LocalStorage.seller_category) ??
                                    [],
                                onConfirm: (value) {
                                  LocalStorage.sharedPreferences.setStringList(
                                      LocalStorage.seller_category, value);
                                });
                          })
                      : const SizedBox(
                          height: 0,
                        ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Are you sure you want to update profile?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            navigationPop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            UserController userController =
                                Get.find<UserController>();
                            if (LocalStorage.sharedPreferences
                                    .getString(LocalStorage.role) ==
                                "seller") {
                              final data = {
                                "id": LocalStorage.sharedPreferences
                                    .getString(LocalStorage.userId),
                                "profile": LocalStorage.sharedPreferences
                                    .getString(LocalStorage.profile),
                                "fcm_token": FirebaseMessaging.instance
                                    .getToken()
                                    .toString(),
                                "name":
                                    userController.nameController.text.trim(),
                                "contact":
                                    userController.phoneController.text.trim(),
                                "seller_category": LocalStorage
                                    .sharedPreferences
                                    .getStringList(LocalStorage.seller_category)
                              };
                              UpdateUserImplementation()
                                  .updateUser(context, data);
                            } else if (LocalStorage.sharedPreferences
                                    .getString(LocalStorage.role) ==
                                "buyer") {
                              final data = {
                                "id": LocalStorage.sharedPreferences
                                    .getString(LocalStorage.userId),
                                "profile": LocalStorage.sharedPreferences
                                    .getString(LocalStorage.profile),
                                "name":
                                    userController.nameController.text.trim(),
                                "fcm_token": FirebaseMessaging.instance
                                    .getToken()
                                    .toString(),
                                "contact":
                                    userController.phoneController.text.trim(),
                              };
                              UpdateUserImplementation()
                                  .updateUser(context, data);
                            } else {
                              log("Something went wrong");
                            }
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: Sizes.s50.h,
                width: Sizes.s145.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Update",
                  style: AppTextStyle.regularTextStyle,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              navigationPop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
              child: Container(
                alignment: Alignment.center,
                height: Sizes.s50.h,
                width: Sizes.s145.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(Sizes.s20.r),
                ),
                child: Text(
                  "Cancel",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
