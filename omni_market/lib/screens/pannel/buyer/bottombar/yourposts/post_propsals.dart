import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/controller/your_posts_controller.dart';
import 'package:omni_market/repository/services/add_contract.dart';
import 'package:omni_market/repository/services/delete_bid.dart';
import 'package:omni_market/repository/services/notification_service.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/yourposts/propsals_detail.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:url_launcher/url_launcher.dart';

class PostProsals extends StatefulWidget {
  const PostProsals({super.key, this.index, this.postId});
  final int? index;
  final String? postId;

  @override
  State<PostProsals> createState() => _PostProsalsState();
}

class _PostProsalsState extends State<PostProsals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: "Post Prosals",
        elevation: 0,
        isBackIcon: true,
        backIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: GetBuilder<YourPostController>(
          init: YourPostController(data: {
            "post_id": widget.postId,
            "buyer_id":
                LocalStorage.sharedPreferences.getString(LocalStorage.userId) ??
                    ''
          }),
          builder: (yourPostController) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
              itemCount: yourPostController.viewPostBidModel.data?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    navigationPush(
                      context,
                      PropsalDetailScreen(
                          index: index, postId: widget.postId ?? ''),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: Sizes.s10.h),
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                    height: Sizes.s100.h,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Sizes.s10.r),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              yourPostController.viewPostBidModel.data?[index]
                                      .sellerId?.name ??
                                  'Utsav',
                              style: AppTextStyle.mediumTextStyle
                                  .copyWith(color: AppColors.blackColor),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to accept this proposal?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            HomeController homeController =
                                                Get.put(HomeController());
                                            await AddContractImplementation()
                                                .addContracts(context, {
                                              "seller_id": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .sellerId
                                                  ?.id,
                                              "post_id": widget.postId,
                                              "buyer_id": LocalStorage
                                                      .sharedPreferences
                                                      .getString(LocalStorage
                                                          .userId) ??
                                                  '',
                                              "diamond_image": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .diamondImage,
                                              "seller_name": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .sellerId
                                                  ?.name,
                                              "seller_contact":
                                                  yourPostController
                                                      .viewPostBidModel
                                                      .data?[index]
                                                      .sellerId
                                                      ?.contact,
                                              "diamond_name": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .diamondName,
                                              "quality_of_rough": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .qualityOfRough,
                                              "cut_of_diamond": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .cutOfDiamond,
                                              "diamond_kararte": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .diamondKarate,
                                              "rating": homeController
                                                  .viewPostModel
                                                  .data?[widget.index ?? 0]
                                                  .rating,
                                              "bid_amount": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .bidAmount,
                                              "diamond_category":
                                                  yourPostController
                                                      .viewPostBidModel
                                                      .data?[index]
                                                      .diamondCategory,
                                              "rough_quality":
                                                  yourPostController
                                                      .viewPostBidModel
                                                      .data?[index]
                                                      .roughQuality,
                                              "polish_type": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .polishType,
                                              "polish_color": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .polishColor,
                                              "start_date": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .startDate,
                                              "end_date": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .endDate,
                                              "description": yourPostController
                                                  .viewPostBidModel
                                                  .data?[index]
                                                  .description,
                                              "total_amount": (int.parse(
                                                      yourPostController
                                                              .viewPostBidModel
                                                              .data?[widget
                                                                      .index ??
                                                                  0]
                                                              .bidAmount ??
                                                          '') *
                                                  int.parse(yourPostController
                                                          .viewPostBidModel
                                                          .data?[
                                                              widget.index ?? 0]
                                                          .postId
                                                          ?.diamondKarate ??
                                                      ''))
                                            });
                                            NotificationsServices
                                                notificationsServices =
                                                NotificationsServices();
                                            notificationsServices
                                                .getFCMToken()
                                                .then((value) async {
                                              print("FCM Token: " +
                                                  value.toString());
                                              var data = {
                                                "priority": "high",
                                                "to": yourPostController
                                                  ..viewPostBidModel
                                                      .data?[widget.index ?? 0]
                                                      .sellerId
                                                      ?.fcmToken,
                                                "notification": {
                                                  "title":
                                                      "${LocalStorage.sharedPreferences.getString(LocalStorage.name)} accept  your post",
                                                  "body": "Check the details"
                                                },
                                                "data": {
                                                  "type": "accept-bid",
                                                }
                                              };
                                              await http.post(
                                                  Uri.parse(
                                                      'https://fcm.googleapis.com/fcm/send'),
                                                  body: data,
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json',
                                                    'Authorization':
                                                        'key=AAAA5A13fTA:APA91bE4f7SjBCkRO-wdaHgv6uKIlcdSSyviEQqA9KtPxv1WzWs1qnYddwSBZm9B4U8CwQd3ahQWkUEMT5OgOQ_yhIaZnPVT0D__-phTT7JJndXKpRkH5gqB2ckF7OIzyDY8O9p2TwiV'
                                                  });
                                            });
                                            notificationsServices
                                                .requestPermission();
                                            notificationsServices
                                                .firebaseInit(context);
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
                                height: Sizes.s40.h,
                                width: Sizes.s45.w,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.s30.r),
                                ),
                                child: const Icon(Icons.check,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                            ScreenUtil().setHorizontalSpacing(10),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to accept this proposal?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            DeleteBidImplementation().deleteBid(
                                                {
                                                  "id": yourPostController
                                                      .viewPostBidModel
                                                      .data?[index]
                                                      .id
                                                },
                                                context);
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: Sizes.s40.h,
                                width: Sizes.s45.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.s30.r),
                                ),
                                child: const Icon(Icons.close,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Contact details"),
                            const Spacer(),
                            TextButton(
                                onPressed: () async {
                                  final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path: yourPostController.viewPostBidModel
                                            .data?[index].sellerId?.contact ??
                                        'Utsav',
                                  );
                                  await launchUrl(launchUri);
                                },
                                child: Text(
                                  "+91 ${yourPostController.viewPostBidModel.data?[index].sellerId?.contact}",
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
