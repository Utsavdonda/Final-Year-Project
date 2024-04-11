import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/image_path.dart';
import 'package:omni_market/screens/auth/regestration.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          context: context,
          title: "Select Role",
          elevation: 0,
          isBackIcon: true,
          backIconPress: () {
            navigationPop(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s30.w),
          child: Center(
            child: Column(children: [
              ScreenUtil().setVerticalSpacing(100),
              InkWell(
                onTap: () {
                  navigationPush(
                    context,
                    RegestationScreen(
                      role: "buyer",
                    ),
                  );
                },
                child: Container(
                  height: Sizes.s150.h,
                  width: Sizes.s150.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.s75.r),
                    color: AppColors.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        ImagePath.sellerIcon,
                        color: AppColors.whiteColor,
                        height: Sizes.s100.sp,
                        width: Sizes.s100.sp,
                      ),
                      Text("Buyer", style: AppTextStyle.mediumTextStyle),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  navigationPush(
                    context,
                    RegestationScreen(
                      role: "seller",
                    ),
                  );
                },
                child: Container(
                  height: Sizes.s150.h,
                  width: Sizes.s150.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.s75.r),
                    color: AppColors.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        ImagePath.sellerIcon,
                        color: AppColors.whiteColor,
                        height: Sizes.s100.sp,
                        width: Sizes.s100.sp,
                      ),
                      Text("Seller", style: AppTextStyle.mediumTextStyle),
                    ],
                  ),
                ),
              ),
              ScreenUtil().setVerticalSpacing(100),
            ]),
          ),
        ),
      ),
    );
  }
}
