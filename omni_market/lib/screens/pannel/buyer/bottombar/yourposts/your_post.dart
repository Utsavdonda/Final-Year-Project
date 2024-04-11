import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/repository/services/delete_post.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/yourposts/post_propsals.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class YourPostsScreen extends StatelessWidget {
  YourPostsScreen({super.key});

  // final _advancedDrawerController = AdvancedDrawerController();

  String formatTimeElapsed(DateTime creationTime) {
    final now = DateTime.now();
    final difference = now.difference(creationTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      final formatter = DateFormat('MMM d, yyyy');
      return formatter.format(creationTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Your Posts", context: context),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return RefreshIndicator(
            onRefresh: homeController.onRefresh,
            child: homeController.isLoading == true
                ? _buildShimmerLoading()
                : homeController.isNoDataFound == true
                    ? _buildNoDataWidget()
                    : _buildPostList(),
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s16.h, vertical: Sizes.s8.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? Colors.red,
            highlightColor: Colors.grey[100] ?? Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: Sizes.s200.h,
                  color: Colors.white,
                ),
                ScreenUtil().setVerticalSpacing(10),
                Container(
                  width: double.infinity,
                  height: Sizes.s16.h,
                  color: Colors.white,
                ),
                ScreenUtil().setVerticalSpacing(10),
                Container(
                  width: double.infinity,
                  height: Sizes.s16.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
        child: Lottie.asset('assets/lottie/nodata.json', height: 200.h));
  }

  Widget _buildPostList() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return ListView.builder(
            itemCount: homeController.viewPostModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
                child: InkWell(
                  onTap: () {
                    navigationPush(
                        context,
                        PostProsals(
                            index: index,
                            postId:
                                homeController.viewPostModel.data?[index].id ??
                                    ''));
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Sizes.s16.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Sizes.s15.r),
                            child: Stack(
                              children: [
                                // Image widget
                                homeController.viewPostModel.data?[index]
                                            .diamondImage?.isEmpty ??
                                        false
                                    ? Image.asset(
                                        height: Sizes.s200.h,
                                        width: double.infinity,
                                        'assets/image/diamond.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        height: Sizes.s200.h,
                                        width: double.infinity,
                                        homeController.viewPostModel
                                                .data?[index].diamondImage ??
                                            'https://media.istockphoto.com/id/481365786/photo/diamond.jpg?s=612x612&w=0&k=20&c=niuZ5_KvgJrK08y-bjpXEsninUBf83ha-44_yrPmqpk=',
                                        fit: BoxFit.cover,
                                      ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Logout"),
                                            backgroundColor:
                                                const Color(0xffF0F4FD),
                                            shadowColor: Colors.black,
                                            buttonPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            content: const Text(
                                              "Are you sure to delete this post?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap: () {
                                                  DeletePostImplementation()
                                                      .deletePosts({
                                                    'id': homeController
                                                        .viewPostModel
                                                        .data?[index]
                                                        .id
                                                  }, context);
                                                },
                                                child: Container(
                                                  width: Sizes.s70.h,
                                                  height: Sizes.s40.w,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: Sizes.s70.h,
                                                  height: Sizes.s40.w,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Center(
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ScreenUtil().setVerticalSpacing(15),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                          child: Row(
                            children: [
                              Text(
                                formatTimeElapsed(homeController
                                        .viewPostModel.data?[index].createdAt ??
                                    DateTime.now()),
                                style: AppTextStyle.smallTextStyle.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: Sizes.s16.sp,
                                ),
                              ),
                              const Spacer(),
                              RatingBar.builder(
                                initialRating: double.parse(homeController
                                        .viewPostModel.data?[index].rating ??
                                    '3.0'),
                                itemSize: Sizes.s18.sp,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: AppColors.primaryColor,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ),
                        ScreenUtil().setVerticalSpacing(10),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState:
                                    homeController.isExpandedList?[index] ??
                                            false
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                firstChild: _buildPostContentReadMore(index),
                                secondChild: _buildPostContentReadLess(
                                    homeController, index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget _buildPostContentReadLess(HomeController homeController, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              homeController.viewPostModel.data?[index].buyerId?.name ??
                  'Utsav Donda',
              style: AppTextStyle.mediumTextStyle.copyWith(
                color: AppColors.blackColor,
                fontSize: Sizes.s24.sp,
              ),
            ),
            ScreenUtil().setHorizontalSpacing(10),
            const Icon(
              Icons.verified_sharp,
              color: Colors.blue,
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(5),
        Text(
          "Karat or Quantity: ${homeController.viewPostModel.data?[index].diamondKarate} ",
          style: AppTextStyle.regularTextStyle.copyWith(
            color: AppColors.blackColor,
          ),
        ),
        ScreenUtil().setVerticalSpacing(15),
        Text(
          homeController.viewPostModel.data?[index].description ?? "",
          style: TextStyle(fontSize: Sizes.s16.sp),
        ),
        ScreenUtil().setVerticalSpacing(10),
        TextButton(
          onPressed: () {
            homeController.isExpandedList?[index] = false;
            homeController.update();
          },
          child: const Text('Read Less...'),
        ),
        Wrap(
          children: List.generate(
              homeController.viewPostModel.data?[index].diamondName?.length ??
                  0,
              (index1) => Padding(
                    padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                    child: SkillChip(
                      skill: homeController.viewPostModel.data?[index]
                              .diamondName?[index1] ??
                          '',
                    ),
                  )),
        )
      ],
    );
  }

  Widget _buildPostContentReadMore(int index) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                homeController.viewPostModel.data?[index].buyerId?.name ??
                    'Utsav Donda',
                style: AppTextStyle.mediumTextStyle.copyWith(
                  color: AppColors.blackColor,
                  fontSize: Sizes.s24.sp,
                ),
              ),
              width10,
              const Icon(
                Icons.verified_sharp,
                color: Colors.blue,
              ),
            ],
          ),
          ScreenUtil().setVerticalSpacing(5),
          Text(
            "Karat or Quantity: ${homeController.viewPostModel.data?[index].diamondKarate} ",
            style: AppTextStyle.regularTextStyle.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          ScreenUtil().setVerticalSpacing(15),
          Text(
            homeController.viewPostModel.data?[index].description ?? "",
            style: TextStyle(fontSize: Sizes.s16.sp),
          ),
          ScreenUtil().setVerticalSpacing(10),
          TextButton(
            onPressed: () {
              homeController.isExpandedList?[index] = true;
              homeController.update();
            },
            child: const Text('Read More...'),
          ),
          Wrap(
            children: List.generate(
                homeController.viewPostModel.data?[index].diamondName?.length ??
                    0,
                (index1) => Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.s4.h),
                      child: SkillChip(
                        skill: homeController.viewPostModel.data?[index]
                                .diamondName?[index1] ??
                            '',
                      ),
                    )),
          )
        ],
      );
    });
  }
}
