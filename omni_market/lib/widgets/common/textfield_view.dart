import 'package:flutter/material.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/utils/validation/textfield_validation.dart';

Widget textview(
    {required BuildContext context,
    String? labelText,
    String? hintText,
    required TextEditingController? controller,
    bool autoFocus = false,
    bool isSuffixWidget = false,
    bool isPrefixWidget = false,
    Widget? suffix,
    Widget? prefix,
    TextInputType? textInputType,
    Function(String value)? onChange,
    bool needValidation = false,
    bool isEmailValidator = false,
    bool isPasswordValidator = false,
    bool isPhoneNumberValidator = false,
    bool obscureText = false,
    bool enabled = false,
    Color? textColor,
    Color? cursorColor,
    Color? labelTextColor,
    Color? enableBordeColor,
    Color? hintTextColor,
    Color? backgroundColor,
    String? validationMessage,
    Color? lableTextColor,
    Color? fontColor,
    Offset? offset1,
    Offset? offset2,
    int? maxLines}) {
  return Container(
    alignment: Alignment.center,
    // height: MediaQuery.of(context).size.height * 0.065,
    decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: AppColors.greyColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(3, 3)),
          BoxShadow(
              color: AppColors.blackColor.withOpacity(0),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1)),
        ]),
    child: TextFormField(
      keyboardType: textInputType ?? TextInputType.url,
      controller: controller,
      onChanged: onChange,
      obscureText: obscureText,
      readOnly: enabled,
      maxLines: maxLines ?? 1,
      validator: needValidation
          ? (value) => TextFieldValidation.validation(
              value: value,
              isPasswordValidator: isPasswordValidator,
              message: validationMessage ?? hintText,
              isEmailValidator: isEmailValidator,
              isPhoneNumberValidator: isPhoneNumberValidator)
          : null,
      style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textColor ?? AppColors.blackColor),
      // style: context.textTheme.displayMedium?.copyWith(
      //   color: textColor ?? AppColors.blackColor,
      //   fontSize: 16,
      //   fontWeight: FontWeight.w600,
      // ),
      cursorColor: cursorColor ?? AppColors.blackColor,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: AppColors.whiteColor,
        suffixIcon: isSuffixWidget ? suffix : null,
        prefixIcon: isPrefixWidget ? prefix : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        // hintStyle: context.textTheme.displayMedium?.copyWith(
        //   color: fontColor ?? Colors.black,
        //   fontWeight: FontWeight.w600,
        // ),
        // labelStyle: context.textTheme.displayMedium?.copyWith(
        //   color: fontColor ?? Colors.black,
        //   fontWeight: FontWeight.w600,
        // ),
        hintStyle: AppTextStyle.regularTextStyle.copyWith(
          color: hintTextColor ?? AppColors.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: AppTextStyle.regularTextStyle.copyWith(
          color: lableTextColor ?? AppColors.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        labelText: labelText,
      ),
    ),
  );
}
