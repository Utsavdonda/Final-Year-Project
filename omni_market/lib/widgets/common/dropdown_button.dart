import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';

Widget buildMultiSelectDialogField({
  required BuildContext context,
  required List<String> items,
  List<String>? selectedValues,
  ValueChanged<List<String>>? onConfirm,
  String? title,
  String? buttonText,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: AppColors.whiteColor,
      boxShadow: [
        BoxShadow(
          color: AppColors.greyColor.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
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
    child: MultiSelectDialogField(
      decoration: const BoxDecoration(),
      separateSelectedItems: true,
      items: items.map((item) => MultiSelectItem(item, item)).toList(),
      initialValue: selectedValues!,
      listType: MultiSelectListType.CHIP,
      buttonIcon: const Icon(Icons.arrow_drop_down),
      title: Text(
        title!,
        style:
            AppTextStyle.regularTextStyle.copyWith(color: AppColors.blackColor),
      ),
      buttonText: Text(
        buttonText!,
        style: AppTextStyle.regularTextStyle
            .copyWith(color: AppColors.blackColor, fontSize: 14.0),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onConfirm: onConfirm!,
    ),
  );
}
