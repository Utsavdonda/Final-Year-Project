import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/post_details/post_details.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/common/textfield_view.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:shimmer/shimmer.dart';

class SearchCatgoryScreen extends StatelessWidget {
  const SearchCatgoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (searchScreenController) {
          return Scaffold(
            body: searchScreenController.isLoading
                ? _buildShimmerContent()
                : searchScreenController.viewPostModel.data?.isEmpty ?? false
                    ? _buildNoDataWidget()
                    : Column(children: [
                        ScreenUtil().setVerticalSpacing(10),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                          child: textview(
                            context: context,
                            controller: search,
                            hintText: "Search",
                            hintTextColor: AppColors.primaryColor,
                            onChange: (value) {
                              searchScreenController.searchViewPostModel.data =
                                  searchScreenController.viewPostModel.data
                                      ?.where((element) =>
                                          element.buyerId?.name?.contains(
                                              element.buyerId?.name ?? '') ??
                                          false)
                                      .toList();

                              // searchScreenController.searchViewPostModel.data =
                              //     searchScreenController.viewPostModel.data
                              //         ?.where((element) =>
                              //             element.diamondName?.any((element) =>
                              //                 element.toLowerCase().contains(
                              //                     value.toLowerCase())) ??
                              //  false)
                              //         .toList();
                              searchScreenController.isSearching = true;
                              searchScreenController.update();
                            },
                            isPrefixWidget: true,
                            prefix: const Icon(Icons.search,
                                color: AppColors.primaryColor),
                          ),
                        ),
                        _buildPostList(),
                      ]),
          );
        });
  }

  Widget _buildPostList() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (searchScreenController) {
          return Expanded(
            child: searchScreenController.isSearching == false
                ? ListView.builder(
                    itemCount:
                        searchScreenController.viewPostModel.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
                        child: InkWell(
                          onTap: () {
                            navigationPush(
                                context,
                                PostDetailsScreen(
                                  index: index,
                                  viewPostModel:
                                      searchScreenController.viewPostModel,
                                ));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(Sizes.s16.h),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.s15.r),
                                    child: searchScreenController
                                                .viewPostModel
                                                .data?[index]
                                                .diamondImage
                                                ?.isEmpty ??
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
                                            searchScreenController
                                                    .viewPostModel
                                                    .data?[index]
                                                    .diamondImage ??
                                                '',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                ScreenUtil().setVerticalSpacing(15),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Sizes.s25.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        formatTimeElapsed(searchScreenController
                                                .viewPostModel
                                                .data?[index]
                                                .createdAt ??
                                            DateTime.now()),
                                        style: AppTextStyle.smallTextStyle
                                            .copyWith(
                                          color: AppColors.blackColor,
                                          fontSize: Sizes.s15.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      RatingBar.builder(
                                        initialRating: double.tryParse(
                                                searchScreenController
                                                        .viewPostModel
                                                        .data?[index]
                                                        .rating ??
                                                    '') ??
                                            0,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Sizes.s25.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        crossFadeState: searchScreenController
                                                    .isExpandedList?[index] ??
                                                false
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        firstChild:
                                            _buildPostContentReadMore(index),
                                        secondChild:
                                            _buildPostContentReadLess(index),
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
                  )
                : ListView.builder(
                    itemCount:
                        searchScreenController.searchViewPostModel.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
                        child: InkWell(
                          onTap: () {
                            print(searchScreenController.isSearching);
                            LocalStorage.setViewPostModel(
                                searchScreenController.searchViewPostModel,
                                index);
                            print(
                                "------------------------${LocalStorage.getViewPostModel()}");
                            navigationPush(
                                context,
                                PostDetailsScreen(
                                  index: index,
                                  viewPostModel: searchScreenController
                                      .searchViewPostModel,
                                ));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(Sizes.s16.h),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.s15.r),
                                    child: searchScreenController
                                                .viewPostModel
                                                .data?[index]
                                                .diamondImage
                                                ?.isEmpty ??
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
                                            searchScreenController
                                                    .viewPostModel
                                                    .data?[index]
                                                    .diamondImage ??
                                                '',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                ScreenUtil().setVerticalSpacing(15),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Sizes.s25.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        formatTimeElapsed(searchScreenController
                                                .searchViewPostModel
                                                .data?[index]
                                                .createdAt ??
                                            DateTime.now()),
                                        style: AppTextStyle.smallTextStyle
                                            .copyWith(
                                          color: AppColors.blackColor,
                                          fontSize: Sizes.s15.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            searchScreenController
                                                    .searchViewPostModel
                                                    .data?[index]
                                                    .rating ??
                                                '0'),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Sizes.s25.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        crossFadeState: searchScreenController
                                                    .isExpandedList?[index] ??
                                                false
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        firstChild:
                                            _buildPostContentReadMore(index),
                                        secondChild:
                                            _buildPostContentReadLess(index),
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
                  ),
          );
        });
  }

  Widget _buildShimmerContent() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.red,
      highlightColor: Colors.grey[100] ?? Colors.red,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
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
            );
          }),
    );
  }

  Widget _buildPostContentReadLess(int index) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (searchScreenController) {
          return searchScreenController.isSearching == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          searchScreenController
                                  .viewPostModel.data?[index].buyerId?.name ??
                              'Utsav Donda',
                          style: AppTextStyle.mediumTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontSize: Sizes.s22.sp,
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
                      "Karat or Quantity: ${searchScreenController.viewPostModel.data?[index].diamondKarate} ",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      searchScreenController
                              .viewPostModel.data?[index].buyerId?.name ??
                          "",
                      style: TextStyle(fontSize: Sizes.s15.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextButton(
                      onPressed: () {
                        searchScreenController.isExpandedList?[index] = false;
                        searchScreenController.update();
                      },
                      child: const Text('Read Less...'),
                    ),
                    Wrap(
                      children: List.generate(
                          searchScreenController.viewPostModel.data?[index]
                                  .diamondName?.length ??
                              0,
                          (index1) => Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: Sizes.s4.h),
                                child: SkillChip(
                                  skill: searchScreenController.viewPostModel
                                          .data?[index].diamondName?[index1] ??
                                      '',
                                ),
                              )),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          searchScreenController.searchViewPostModel
                                  .data?[index].buyerId?.name ??
                              'Utsav Donda',
                          style: AppTextStyle.mediumTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontSize: Sizes.s22.sp,
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
                      "Karat or Quantity: ${searchScreenController.searchViewPostModel.data?[index].diamondKarate} ",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      searchScreenController
                              .searchViewPostModel.data?[index].buyerId?.name ??
                          "",
                      style: TextStyle(fontSize: Sizes.s15.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextButton(
                      onPressed: () {
                        searchScreenController.isExpandedList?[index] = false;
                        searchScreenController.update();
                      },
                      child: const Text('Read Less...'),
                    ),
                    Wrap(
                      children: List.generate(
                          searchScreenController.searchViewPostModel
                                  .data?[index].diamondName?.length ??
                              0,
                          (index1) => Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: Sizes.s4.h),
                                child: SkillChip(
                                  skill: searchScreenController
                                          .searchViewPostModel
                                          .data?[index]
                                          .diamondName?[index1] ??
                                      '',
                                ),
                              )),
                    )
                  ],
                );
        });
  }

  Widget _buildPostContentReadMore(int index) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (searchScreencontroller) {
          return searchScreencontroller.isSearching == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          searchScreencontroller
                                  .viewPostModel.data?[index].buyerId?.name ??
                              'Utsav Donda',
                          style: AppTextStyle.mediumTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontSize: Sizes.s22.sp,
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
                      "Karat or Quantity: ${searchScreencontroller.viewPostModel.data?[index].diamondKarate} ",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      searchScreencontroller
                              .viewPostModel.data?[index].buyerId?.name ??
                          "",
                      style: TextStyle(fontSize: Sizes.s15.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextButton(
                      onPressed: () {
                        searchScreencontroller.isExpandedList?[index] = true;
                        searchScreencontroller.update();
                      },
                      child: const Text('Read More...'),
                    ),
                    Wrap(
                      children: List.generate(
                          searchScreencontroller.viewPostModel.data?[index]
                                  .diamondName?.length ??
                              0,
                          (index1) => Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: Sizes.s4.h),
                                child: SkillChip(
                                  skill: searchScreencontroller.viewPostModel
                                          .data?[index].diamondName?[index1] ??
                                      '',
                                ),
                              )),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          searchScreencontroller.searchViewPostModel
                                  .data?[index].buyerId?.name ??
                              'Utsav Donda',
                          style: AppTextStyle.mediumTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontSize: Sizes.s22.sp,
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
                      "Karat or Quantity: ${searchScreencontroller.searchViewPostModel.data?[index].diamondKarate} ",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(15),
                    Text(
                      searchScreencontroller
                              .searchViewPostModel.data?[index].buyerId?.name ??
                          "",
                      style: TextStyle(fontSize: Sizes.s16.sp),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextButton(
                      onPressed: () {
                        searchScreencontroller.isExpandedList?[index] = true;
                        searchScreencontroller.update();
                      },
                      child: const Text('Read More...'),
                    ),
                    Wrap(
                      children: List.generate(
                          searchScreencontroller.searchViewPostModel
                                  .data?[index].diamondName?.length ??
                              0,
                          (index1) => Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: Sizes.s4.h),
                                child: SkillChip(
                                  skill: searchScreencontroller
                                          .searchViewPostModel
                                          .data?[index]
                                          .diamondName?[index1] ??
                                      '',
                                ),
                              )),
                    )
                  ],
                );
        });
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Lottie.asset('assets/lottie/nodata.json'),
    );
  }

  String formatTimeElapsed(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      final formatter = DateFormat('MMM d, yyyy');
      return formatter.format(dateTime);
    }
  }
}
