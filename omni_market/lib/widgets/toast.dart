import 'package:fluttertoast/fluttertoast.dart';
import 'package:omni_market/config/app_color.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      textColor: AppColors.whiteColor,
      backgroundColor: AppColors.blackColor);
}
