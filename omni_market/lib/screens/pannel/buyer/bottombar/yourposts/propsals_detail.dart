import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/your_posts_controller.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/size.dart';

class PropsalDetailScreen extends StatefulWidget {
  const PropsalDetailScreen({
    super.key,
    required this.index,
    required this.postId,
  });
  final int index;
  final String postId;

  @override
  State<PropsalDetailScreen> createState() => _PropsalDetailScreenState();
}

class _PropsalDetailScreenState extends State<PropsalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<YourPostController>(
        init: YourPostController(data: {
          "post_id": widget.postId,
          "buyer_id":
              LocalStorage.sharedPreferences.getString(LocalStorage.userId) ??
                  ''
        }),
        builder: (yourPostController) {
          return Scaffold(
              appBar: appBar(
                context: context,
                title: "Propsal Detail",
                elevation: 0,
                isBackIcon: true,
                backIconPress: () {
                  Navigator.pop(context);
                },
              ),
              body: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      vertical: Sizes.s10.h, horizontal: Sizes.s16.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
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
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizes.s10.h, horizontal: Sizes.s16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Utsav Donda",
                              style: AppTextStyle.mediumTextStyle.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: Sizes.s24.sp),
                            ),
                            ScreenUtil().setHorizontalSpacing(10),
                            const Icon(Icons.verified, color: Colors.blue),
                            const Spacer(),
                            RatingBar.builder(
                              initialRating: 3.5,
                              itemSize: Sizes.s20.sp,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: AppColors.primaryColor,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Carat price: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: yourPostController.viewPostBidModel
                                      .data![widget.index].bidAmount,
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Carat quantity: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: yourPostController
                                          .viewPostBidModel
                                          .data?[widget.index]
                                          .postId
                                          ?.diamondKarate ??
                                      '',
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Total amount: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: (int.parse(yourPostController
                                                  .viewPostBidModel
                                                  .data?[widget.index]
                                                  .bidAmount ??
                                              '') *
                                          int.parse(yourPostController
                                                  .viewPostBidModel
                                                  .data?[widget.index]
                                                  .postId
                                                  ?.diamondKarate ??
                                              ''))
                                      .toString(),
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Starting date: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: yourPostController.viewPostBidModel
                                          .data?[widget.index].startDate ??
                                      '',
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Delivery date: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: yourPostController.viewPostBidModel
                                          .data?[widget.index].endDate ??
                                      '',
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                              text: "Payment Time: ",
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: "7 Days",
                                  style: AppTextStyle.mediumTextStyle
                                      .copyWith(color: AppColors.blackColor),
                                ),
                                TextSpan(
                                  text: " after delivery*",
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                      color: AppColors.blackColor,
                                      fontSize: Sizes.s16.sp),
                                ),
                              ]),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        Text(
                          "Seller Category",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                        ),
                        ScreenUtil().setVerticalSpacing(5),
                        Wrap(
                          children: List.generate(
                              yourPostController
                                      .viewPostBidModel
                                      .data?[widget.index]
                                      .postId
                                      ?.diamondName
                                      ?.length ??
                                  0,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Sizes.s4.h),
                                    child: SkillChip(
                                      skill: yourPostController
                                              .viewPostBidModel
                                              .data?[widget.index]
                                              .postId
                                              ?.diamondName?[index] ??
                                          '',
                                    ),
                                  )),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        Text(
                          "Rough Quality",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                        ),
                        ScreenUtil().setVerticalSpacing(5),
                        Wrap(
                          children: List.generate(
                              yourPostController
                                      .viewPostBidModel
                                      .data?[widget.index]
                                      .postId
                                      ?.qualityOfRough
                                      ?.length ??
                                  0,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Sizes.s4.h),
                                    child: SkillChip(
                                      skill: yourPostController
                                              .viewPostBidModel
                                              .data?[widget.index]
                                              .postId
                                              ?.qualityOfRough?[index] ??
                                          '',
                                    ),
                                  )),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        Text(
                          "Polish type",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                        ),
                        ScreenUtil().setVerticalSpacing(5),
                        Wrap(
                          children: List.generate(
                              yourPostController
                                      .viewPostBidModel
                                      .data?[widget.index]
                                      .postId
                                      ?.polishType
                                      ?.length ??
                                  0,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Sizes.s4.h),
                                    child: SkillChip(
                                      skill: yourPostController
                                              .viewPostBidModel
                                              .data?[widget.index]
                                              .postId
                                              ?.polishType?[index] ??
                                          '',
                                    ),
                                  )),
                        ),
                        Text(
                          "Polish color",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                        ),
                        ScreenUtil().setVerticalSpacing(5),
                        Wrap(
                          children: List.generate(
                              yourPostController
                                      .viewPostBidModel
                                      .data?[widget.index]
                                      .postId
                                      ?.polishColor
                                      ?.length ??
                                  0,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Sizes.s4.h),
                                    child: SkillChip(
                                      skill: yourPostController
                                              .viewPostBidModel
                                              .data?[widget.index]
                                              .postId
                                              ?.polishColor?[index] ??
                                          '',
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                )
              ])));
        });
  }
}
