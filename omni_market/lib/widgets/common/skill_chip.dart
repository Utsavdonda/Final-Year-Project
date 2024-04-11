import 'package:flutter/material.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/widgets/size.dart';

class SkillChip extends StatelessWidget {
  final String skill;
  // double? width;
  // double? height;

  const SkillChip({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          height: Sizes.s30.h,
          width: Sizes.s42.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            skill,
            style: AppTextStyle.regularTextStyle
                .copyWith(color: AppColors.whiteColor, fontSize: Sizes.s10.sp),
          )),
    );
  }
}
