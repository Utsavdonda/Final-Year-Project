import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/diamond_controler.dart';
import 'package:omni_market/repository/services/add_bid_service.dart';
import 'package:omni_market/repository/services/notification_service.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/button_view.dart';
import 'package:omni_market/widgets/common/dropdown_button.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

// ignore: must_be_immutable
class BiddingScreen extends StatelessWidget {
  BiddingScreen({
    super.key,
    required this.index,
    required this.bidAmount,
    required this.postId,
    required this.fcmToken,
  });

  final int index;
  final int bidAmount;
  final String postId;
  final String fcmToken;

  TextEditingController bidAmountController = TextEditingController();

  TextEditingController roughQualityController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  DateTime? startDate;

  DateTime? endDate;

  String? formattedStartDate;

  String? formattedEndDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DiamondController>(
        init: DiamondController(),
        builder: (controller) {
          return Scaffold(
            appBar: appBar(
              context: context,
              title: "Submit Proposal",
              isBackIcon: true,
              backIconPress: () {
                Navigator.pop(context);
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenUtil().setVerticalSpacing(10),
                    Text(
                      'Bid Amount',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(5),
                    textview(
                      context: context,
                      controller: bidAmountController,
                      hintText: "Enter Bid Amount",
                      textInputType: TextInputType.number,
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Diamond category',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    buildMultiSelectDialogField(
                      context: context,
                      buttonText: "Diamond category",
                      items: controller.viewDiamondModel.data?[0].diamondName ??
                          [],
                      selectedValues: controller.selectedDiamondCateogry,
                      onConfirm: (value) {
                        controller.setSelectedDiamondCateogry(value);
                      },
                      title: "Diamond category",
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Diamond Cut',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    buildMultiSelectDialogField(
                      context: context,
                      selectedValues: controller.selectedDiamondCut,
                      items:
                          controller.viewDiamondModel.data?[0].cutOfDiamond ??
                              [],
                      buttonText: "Diamond Cut",
                      title: "Diamond Cut",
                      onConfirm: (value) {
                        controller.setSelectedDiamondCut(value);
                      },
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Rough quality',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    buildMultiSelectDialogField(
                      context: context,
                      selectedValues: controller.selectedRoughQuality,
                      items:
                          controller.viewDiamondModel.data?[0].qualityOfRough ??
                              [],
                      buttonText: "Rough quality",
                      title: "Rough quality",
                      onConfirm: (value) {
                        controller.setSelectedRoughQuality(value);
                      },
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Polish type',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    buildMultiSelectDialogField(
                      context: context,
                      selectedValues: controller.selectedPolishType,
                      items:
                          controller.viewDiamondModel.data?[0].polishType ?? [],
                      buttonText: "Polish type",
                      title: "Polish type",
                      onConfirm: (value) {
                        controller.setSelectedPolishType(value);
                      },
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Polish color',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    buildMultiSelectDialogField(
                      context: context,
                      selectedValues: controller.selectedPolishcolor,
                      items: controller.viewDiamondModel.data?[0].polishColor ??
                          [],
                      buttonText: "Polish color",
                      title: "Polish color",
                      onConfirm: (value) {
                        controller.setSelectedPolishcolor(value);
                      },
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      'Add description',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black, fontSize: Sizes.s18.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    textview(
                      context: context,
                      maxLines: 4,
                      controller: descriptionController,
                      hintText: "Description",
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Center(
                      child: AnimatedButtonView(
                        onTap: () async {
                          await controller.selectStartDate(context);
                        },
                        title: controller.forrmateStartDate ??
                            "Select starting date",
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Center(
                      child: AnimatedButtonView(
                        onTap: () async {
                          await controller.selectEndDate(context);
                        },
                        title: controller.forrmateEndDate ??
                            "Select delivery date",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text(
                                'Are you sure you want to send this proposal?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Map<String, dynamic> data = {
                                    "seller_id": LocalStorage.sharedPreferences
                                        .getString(LocalStorage.userId),
                                    "post_id": postId,
                                    "bid_amount":
                                        int.parse(bidAmountController.text),
                                    "diamond_category":
                                        controller.selectedDiamondCateogry,
                                    "cut_of_diamond":
                                        controller.selectedDiamondCut,
                                    "rough_quality":
                                        controller.selectedRoughQuality,
                                    "polish_type":
                                        controller.selectedPolishType,
                                    "polish_color":
                                        controller.selectedPolishcolor,
                                    "start_date": controller.forrmateStartDate,
                                    "end_date": controller.forrmateEndDate,
                                    "description": descriptionController.text
                                  };
                                  await AddBidImplementation()
                                      .addBids(data, context);

                                  NotificationsServices notificationsServices =
                                      NotificationsServices();
                                  notificationsServices
                                      .getFCMToken()
                                      .then((value) async {
                                    print("FCM Token: " + value.toString());
                                    var data = {
                                      "priority": "high",
                                      "to": fcmToken,
                                      "notification": {
                                        "title":
                                            "${LocalStorage.sharedPreferences.getString(LocalStorage.name)} bid on your post",
                                        "body": "Check the details"
                                      },
                                      "data": {
                                        "type": "bid",
                                      }
                                    };
                                    await http.post(
                                        Uri.parse(
                                            'https://fcm.googleapis.com/fcm/send'),
                                        body: data,
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization':
                                              'key=AAAA5A13fTA:APA91bE4f7SjBCkRO-wdaHgv6uKIlcdSSyviEQqA9KtPxv1WzWs1qnYddwSBZm9B4U8CwQd3ahQWkUEMT5OgOQ_yhIaZnPVT0D__-phTT7JJndXKpRkH5gqB2ckF7OIzyDY8O9p2TwiV'
                                        });
                                  });
                                  notificationsServices.requestPermission();
                                  notificationsServices.firebaseInit(context);
                                  notificationsServices
                                      .setupInteractMessage(context);
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.s50.h,
                      width: Sizes.s145.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(Sizes.s10.r),
                      ),
                      child: Text(
                        "Submit a Proposal",
                        style: AppTextStyle.regularTextStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                  child: InkWell(
                    onTap: () {
                      navigationPop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.s50.h,
                      width: Sizes.s145.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(Sizes.s10.r),
                      ),
                      child: Text(
                        "Cancel",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
