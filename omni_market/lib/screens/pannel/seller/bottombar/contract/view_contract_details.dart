import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/model/view_contract_model.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class SellerViewContractDetailsScreen extends StatelessWidget {
  const SellerViewContractDetailsScreen(
      {super.key, required this.index, required this.viewContractModel});
  final int index;
  final ViewContractModel viewContractModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          backIconPress: () {
            navigationPop(context);
          },
          isBackIcon: true,
          title: "View Contract",
          context: context),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      offset: const Offset(3, 3),
                    ),
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
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
                            viewContractModel.data?[index].buyerId?.name ?? "",
                            style: AppTextStyle.mediumTextStyle.copyWith(
                                color: AppColors.blackColor,
                                fontSize: Sizes.s18.sp),
                          ),
                          width10,
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
                              text: viewContractModel.data?[index].bidAmount,
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(10),
                      RichText(
                        text: TextSpan(
                          text: "Total amount: ",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                          children: [
                            TextSpan(
                                text: viewContractModel
                                        .data?[index].totalAmount ??
                                    '',
                                style: AppTextStyle.mediumTextStyle
                                    .copyWith(color: AppColors.blackColor)),
                          ],
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(10),
                      RichText(
                        text: TextSpan(
                          text: "Starting date: ",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                          children: [
                            TextSpan(
                              text: viewContractModel.data?[index].startDate ??
                                  '',
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(10),
                      RichText(
                        text: TextSpan(
                          text: "Delivery date: ",
                          style: AppTextStyle.mediumTextStyle
                              .copyWith(color: AppColors.blackColor),
                          children: [
                            TextSpan(
                              text:
                                  viewContractModel.data?[index].endDate ?? '',
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                            ),
                          ],
                        ),
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
                          viewContractModel.data?[index].diamondName?.length ??
                              0,
                          (index1) => Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                            child: SkillChip(
                              skill: viewContractModel
                                      .data?[index].diamondName?[index1] ??
                                  '',
                            ),
                          ),
                        ),
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
                          viewContractModel
                                  .data?[index].qualityOfRough?.length ??
                              0,
                          (index1) => Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                            child: SkillChip(
                              skill: viewContractModel
                                      .data?[index].qualityOfRough?[index1] ??
                                  '',
                            ),
                          ),
                        ),
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
                          viewContractModel.data?[index].polishType?.length ??
                              0,
                          (index1) => Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                            child: SkillChip(
                              skill: viewContractModel
                                      .data?[index].polishType?[index1] ??
                                  '',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Polish color",
                        style: AppTextStyle.mediumTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      ScreenUtil().setVerticalSpacing(5),
                      Wrap(
                        children: List.generate(
                          viewContractModel.data?[index].polishColor?.length ??
                              0,
                          (index1) => Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                            child: SkillChip(
                              skill: viewContractModel
                                      .data?[index].polishColor?[index1] ??
                                  '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
