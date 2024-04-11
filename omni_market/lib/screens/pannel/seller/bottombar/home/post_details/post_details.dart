import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/model/viewpost_model.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/biding_screen/biding_screen.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/demo_list.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../widgets/navigation.dart';

// ignore: must_be_immutable
class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, this.index, this.viewPostModel});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
  int? index;
  ViewPostModel? viewPostModel;
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar(
        context: context,
        title: "Post Detials",
        elevation: 0,
        isBackIcon: true,
        backIconPress: () => navigationPop(context),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            ScreenUtil().setVerticalSpacing(20),
            CarouselSlider(
              items:
                  (diamondList[0].images as List<String>).map<Widget>((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.s10.r),
                  child: Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (diamondList.first.images as List<String>)
                  .asMap()
                  .entries
                  .map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: Sizes.s10.w,
                    height: Sizes.s10.h,
                    margin: EdgeInsets.symmetric(
                      vertical: Sizes.s8.h,
                      horizontal: Sizes.s4.w,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
            ScreenUtil().setVerticalSpacing(20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                child: Row(children: [
                  Text(
                    widget.viewPostModel?.data?[widget.index ?? 0].buyerId
                            ?.name ??
                        'No Available',
                    style: AppTextStyle.mediumTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s20.sp,
                    ),
                  ),
                  width10,
                  const Icon(Icons.verified_sharp, color: Colors.blue)
                ])),
            Padding(
              padding: EdgeInsets.only(left: Sizes.s25.w),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Karat / Quantity:",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: Sizes.s18.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  width10,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.viewPostModel?.data?[widget.index ?? 0]
                              .diamondKarate ??
                          'No Data Available',
                      style: AppTextStyle.regularTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: Sizes.s18.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Diamond Cut",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            widget.viewPostModel?.data?[widget.index ?? 0].cutOfDiamond
                        ?.isEmpty ??
                    false
                ? const Text("No Data Available")
                : Wrap(
                    children: List.generate(
                        widget.viewPostModel?.data?[widget.index ?? 0]
                                .cutOfDiamond?.length ??
                            0,
                        (index1) => Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: Sizes.s4.h),
                              child: SkillChip(
                                skill: widget
                                        .viewPostModel
                                        ?.data?[widget.index ?? 0]
                                        .cutOfDiamond?[index1] ??
                                    '',
                              ),
                            )),
                  ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Diamond Category",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            widget.viewPostModel?.data?[widget.index ?? 0].diamondName
                        ?.isEmpty ??
                    false
                ? const Text("No Data Available")
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                      child: Wrap(
                        children: List.generate(
                            widget.viewPostModel?.data?[widget.index!]
                                    .diamondName?.length ??
                                0,
                            (index1) => SkillChip(
                                  skill: widget
                                          .viewPostModel
                                          ?.data?[widget.index!]
                                          .diamondName?[index1] ??
                                      '',
                                )),
                      ),
                    ),
                  ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Polish Color",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            widget.viewPostModel?.data?[widget.index ?? 0].polishColor
                        ?.isEmpty ??
                    false
                ? const Text("No Data Available")
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                      child: Wrap(
                        children: List.generate(
                            widget.viewPostModel?.data?[widget.index!]
                                    .polishColor?.length ??
                                0,
                            (index1) => SkillChip(
                                  skill: widget
                                          .viewPostModel
                                          ?.data?[widget.index!]
                                          .polishColor?[index1] ??
                                      '',
                                )),
                      ),
                    ),
                  ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Polish Type",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            widget.viewPostModel?.data?[widget.index ?? 0].polishType
                        ?.isEmpty ??
                    false
                ? const Text("No Data Available")
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                      child: Wrap(
                        children: List.generate(
                            widget.viewPostModel?.data?[widget.index!]
                                    .polishType?.length ??
                                0,
                            (index1) => SkillChip(
                                  skill: widget
                                          .viewPostModel
                                          ?.data?[widget.index ?? 0]
                                          .polishType?[index1] ??
                                      '',
                                )),
                      ),
                    ),
                  ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                child: Text(
                  widget.viewPostModel?.data?[widget.index ?? 0].description ??
                      "No Data Available",
                )),
          ])),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
            child: InkWell(
              onTap: () {
                navigationPush(
                    context,
                    BiddingScreen(
                      fcmToken: widget.viewPostModel?.data?[widget.index ?? 0]
                              .buyerId?.fcmToken ??
                          '',
                      bidAmount: int.parse(widget.viewPostModel
                              ?.data?[widget.index ?? 0].diamondKarate ??
                          "There is no bid amount available"),
                      index: widget.index ?? 0,
                      postId:
                          widget.viewPostModel?.data?[widget.index ?? 0].id ??
                              'There is no post id available',
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                height: Sizes.s50.h,
                width: Sizes.s145.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Apply Now",
                  style: AppTextStyle.regularTextStyle,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
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
                borderRadius: BorderRadius.circular(Sizes.s20.r),
              ),
              child: Text(
                "Save Job",
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
