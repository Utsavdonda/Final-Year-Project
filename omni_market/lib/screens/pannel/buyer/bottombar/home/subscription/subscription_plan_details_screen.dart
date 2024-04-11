import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/repository/services/payment_service.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

class BuyerSubscriptionDetails extends StatelessWidget {
  const BuyerSubscriptionDetails({
    super.key,
    required this.plan,
  });
  final plan;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
            backIconPress: () {
              navigationPop(context);
            },
            title: "Plan details",
            isBackIcon: true,
            context: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenUtil().setVerticalSpacing(10),
                Text(
                  "Subscription Plan",
                  style: AppTextStyle.mediumTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                ScreenUtil().setVerticalSpacing(5),
                Card(
                  color: AppColors.primaryColor,
                  borderOnForeground: true,
                  child: ListTile(
                    leading: const Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: AppColors.whiteColor,
                    ),
                    title: Text(
                      "${plan['name']}",
                      style: AppTextStyle.regularTextStyle,
                    ),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                Text(
                  "Features",
                  style: AppTextStyle.mediumTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                ScreenUtil().setVerticalSpacing(5),
                Card(
                  color: AppColors.primaryColor,
                  borderOnForeground: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: plan['features'].length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.fiber_manual_record,
                          size: 12,
                          color: AppColors.whiteColor,
                        ),
                        title: Text(
                          plan['features'][index],
                          style: AppTextStyle.regularTextStyle,
                        ),
                      );
                    },
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                Text(
                  "Duration",
                  style: AppTextStyle.mediumTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                ScreenUtil().setVerticalSpacing(5),
                Card(
                  color: AppColors.primaryColor,
                  borderOnForeground: true,
                  child: ListTile(
                    leading: const Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: AppColors.whiteColor,
                    ),
                    title: Text(
                      "${plan['time']} month",
                      style: AppTextStyle.regularTextStyle,
                    ),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                Text(
                  "Price",
                  style: AppTextStyle.mediumTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                ScreenUtil().setVerticalSpacing(5),
                Card(
                  color: AppColors.primaryColor,
                  borderOnForeground: true,
                  child: ListTile(
                    leading: const Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: AppColors.whiteColor,
                    ),
                    title: Text(
                      "₹${plan['price']}",
                      style: AppTextStyle.regularTextStyle,
                    ),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedButtonView(
                    title: "Subscribe",
                    onTap: () {
                      _handlePayment(context, plan['price']);
                    },
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePayment(BuildContext context, int price) async {
    String? phone =
        LocalStorage.sharedPreferences.getString(LocalStorage.phone);
    String? email =
        LocalStorage.sharedPreferences.getString(LocalStorage.email);

    await PaymentService(
            amount: price, contact: phone!, type: plan['name'], email: email!)
        .razorPayService(context);
  }
}
