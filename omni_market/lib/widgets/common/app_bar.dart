import 'package:flutter/material.dart';
import 'package:omni_market/config/app_color.dart';

PreferredSizeWidget appBar(
    {required String title,
    required BuildContext context,
    TextEditingController? controller,
    List<Widget>? action,
    bool isDrawer = false,
    bool isBackIcon = false,
    Widget? drawer,
    double elevation = 5,
    Widget? titleWidget,
   
    bool isTitleWidget = false,
    bool isSeacing = false,
    Function()? backIconPress,
    Function()? onChange,
    Widget? drawerTrigger,
    IconData? icon // Added this line

    }) {
  return AppBar(
    title: Text(title,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
    leading: isDrawer
        ? drawerTrigger // Changed this line
        : isBackIcon
            ? IconButton(
                onPressed: backIconPress,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                ),
              )
            : Icon(
                icon,
                color: AppColors.whiteColor,
              ),
    backgroundColor: AppColors.primaryColor,
    elevation: elevation,
    actions: action,

  );
}
