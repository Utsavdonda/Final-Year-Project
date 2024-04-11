import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/diamond_controler.dart';
import 'package:omni_market/repository/services/add_post_service.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/common/dropdown_button.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController description = TextEditingController();
    return GetBuilder<DiamondController>(
        init: DiamondController(),
        builder: (diamondController) {
          return Scaffold(
            appBar: appBar(
              context: context,
              title: 'Add Post',
              elevation: 0,
              isBackIcon: true,
              backIconPress: () {
                navigationPop(context);
              },
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
              children: [
                ScreenUtil().setVerticalSpacing(20),
                Align(
                  alignment: Alignment.center,
                  child: Text("Add image",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
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
                                diamondController.pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("Gallery"),
                              onTap: () {
                                diamondController
                                    .pickImage(ImageSource.gallery);
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
                    child: diamondController.imageFile == null
                        ? Container(
                            height: Sizes.s130.h,
                            width: Sizes.s140.w,
                            color: Colors.grey,
                            child: Icon(
                              Icons.camera_alt,
                              size: Sizes.s40.sp,
                              color: Colors.white,
                            ),
                          )
                        : Image.file(
                            diamondController.imageFile ?? File(""),
                            fit: BoxFit.cover,
                            height: Sizes.s130.h,
                            width: Sizes.s140.w,
                          ),
                  )),
                ),
               
                ScreenUtil().setVerticalSpacing(15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter the quantity of carat",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                textview(
                  context: context,
                  controller: controller,
                  hintText: 'Enter the Carat of the Diamond',
                ),
                ScreenUtil().setVerticalSpacing(5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Diamond Category",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                buildMultiSelectDialogField(
                    context: context,
                    buttonText: "Diamond Category",
                    title: "Diamond Category",
                    selectedValues: diamondController.selectedDiamondCateogry,
                    items: diamondController
                            .viewDiamondModel.data?[0].diamondName ??
                        [],
                    onConfirm: (value) {
                      diamondController.setSelectedDiamondCateogry(value);
                    }),
                ScreenUtil().setVerticalSpacing(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Diamond Cut",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                buildMultiSelectDialogField(
                    context: context,
                    buttonText: "Diamond Cut",
                    title: "Diamond Cut",
                    selectedValues: diamondController.selectedDiamondCut,
                    items: diamondController
                            .viewDiamondModel.data?[0].cutOfDiamond ??
                        [],
                    onConfirm: (value) {
                      diamondController.setSelectedDiamondCut(value);
                    }),
                ScreenUtil().setVerticalSpacing(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rough Quality",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                buildMultiSelectDialogField(
                    context: context,
                    buttonText: "Rough quality",
                    title: "Rough quality",
                    selectedValues: diamondController.selectedRoughQuality,
                    items: diamondController
                            .viewDiamondModel.data?[0].qualityOfRough ??
                        [],
                    onConfirm: (value) {
                      diamondController.setSelectedRoughQuality(value);
                    }),
                ScreenUtil().setVerticalSpacing(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Polish quality",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                buildMultiSelectDialogField(
                    context: context,
                    buttonText: "Polish quality",
                    title: "Polish quality",
                    selectedValues: diamondController.selectedPolishType,
                    items: diamondController
                            .viewDiamondModel.data?[0].polishType ??
                        [],
                    onConfirm: (value) {
                      diamondController.setSelectedPolishType(value);
                    }),
                ScreenUtil().setVerticalSpacing(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Polish color",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                buildMultiSelectDialogField(
                    context: context,
                    buttonText: "Polish color",
                    title: "Polish color",
                    selectedValues: diamondController.selectedPolishcolor,
                    items: diamondController
                            .viewDiamondModel.data?[0].polishColor ??
                        [],
                    onConfirm: (value) {
                      diamondController.setSelectedPolishcolor(value);
                    }),
                ScreenUtil().setVerticalSpacing(15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Description",
                      style: AppTextStyle.mediumTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: Sizes.s16.sp,
                      )),
                ),
                ScreenUtil().setVerticalSpacing(10),
                textview(
                  context: context,
                  controller: description,
                  hintText: 'Description',
                  maxLines: 4,
                ),
                ScreenUtil().setVerticalSpacing(15),
                AnimatedButtonView(
                  title: "Add post",
                  onTap: () async {
                    final data = {
                      "buyer_id": LocalStorage.sharedPreferences
                          .getString(LocalStorage.userId),
                      "diamond_image": diamondController.uploadedFileURL,
                      "diamond_karate": controller.text,
                      "diamond_name": diamondController.selectedDiamondCateogry,
                      "cut_of_diamond": diamondController.selectedDiamondCut,
                      "quality_of_rough":
                          diamondController.selectedRoughQuality,
                      "polish_type": diamondController.selectedPolishType,
                      "polish_color": diamondController.selectedPolishcolor,
                      "description": description.text,
                    };

                    await AddPostImplementation().addPosts(data, context);
                  },
                )
              ],
            ),
          );
        });
  }
}
