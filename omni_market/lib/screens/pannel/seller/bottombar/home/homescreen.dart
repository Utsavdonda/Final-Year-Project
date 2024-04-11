import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/repository/services/add_review.dart';
import 'package:omni_market/screens/auth/login_screen.dart';
import 'package:omni_market/screens/auth/user_details_screen.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/post_details/post_details.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/subscription/subscription_screen.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();

  TextEditingController search = TextEditingController();

  TextEditingController shareExperienceController = TextEditingController();
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
    String? name = LocalStorage.sharedPreferences.getString(LocalStorage.name);
    String? email =
        LocalStorage.sharedPreferences.getString(LocalStorage.email);
    String? photo =
        LocalStorage.sharedPreferences.getString(LocalStorage.profile);
    bool? isVerified =
        LocalStorage.sharedPreferences.getBool(LocalStorage.isVerified);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
        return AdvancedDrawer(
            backdrop: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            controller: _advancedDrawerController,
            childDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s16.r),
            ),
            drawer: SafeArea(
              child: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Row(
                        children: [
                          Text(name ?? 'User Name'),
                          ScreenUtil().setHorizontalSpacing(10),
                          if (isVerified ?? false)
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                      accountEmail: Text(email ?? 'User Email'),
                      currentAccountPicture: photo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(photo))
                          : const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person),
                            ),
                    ),
                    ListTile(
                      onTap: () {
                        navigationPush(context, const UserDetailScreen());
                      },
                      leading: const Icon(Icons.account_circle_rounded),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Profile'),
                    ),
                    ListTile(
                      onTap: () {
                        navigationPush(context, SellerSubscriptionsScreen());
                      },
                      leading: const Icon(Icons.subscriptions_rounded),
                      title: const Text('Subscriptions'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () async {
                        String email =
                            Uri.encodeComponent("utsavdonda22@gmail.com");
                        String subject = Uri.encodeComponent("Hello Flutter");
                        Uri mail = Uri.parse("mailto:$email?subject=$subject");
                        if (await launchUrl(mail)) {
                          await launchUrl(mail);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Sorry...can't open your mail",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              textColor: Colors.white,
                              backgroundColor: Colors.blue);
                        }
                      },
                      title: const Text('Support'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      leading: const Icon(Icons.support_agent_rounded),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Rate this Application"),
                              backgroundColor: const Color(0xffF0F4FD),
                              shadowColor: Colors.black,
                              buttonPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              content: Container(
                                height: 100,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      updateOnDrag: true,
                                      itemCount: 5,
                                      allowHalfRating: true,
                                      unratedColor: Colors.grey.shade400,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (value) {
                                        homeController.rating = value;
                                        homeController.update();
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: shareExperienceController,
                                      decoration: const InputDecoration(
                                          hintText: "Share your experience"),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Later",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    AddReviewImplementation()
                                        .addReview(context, {
                                      "client_id": LocalStorage
                                          .sharedPreferences
                                          .getString(LocalStorage.userId),
                                      "rating": homeController.rating,
                                      "message": shareExperienceController.text,
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                      title: const Text('FeedBack'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      leading: const Icon(Icons.feedback_rounded),
                    ),
                    ListTile(
                      onTap: () {
                        Share.share('com.example.omni_market');
                      },
                      title: const Text('Share'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      leading: const Icon(Icons.share),
                    ),
                    const Spacer(),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              backgroundColor: const Color(0xffF0F4FD),
                              shadowColor: Colors.black,
                              buttonPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              content: const Text(
                                "Are you sure to logout?",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              actions: [
                                InkWell(
                                  onTap: () async {
                                    await LocalStorage.sharedPreferences
                                        .clear();
                                    navigationPushAndRemoveUntil(
                                        context, const LoginScreen());
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                                    width: 70,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                      trailing: const Icon(Icons.arrow_forward_ios),
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
            child: Scaffold(
              appBar: appBar(
                context: context,
                title: "Home Screen",
                isDrawer: true,
                elevation: 0,
                drawerTrigger: InkWell(
                  onTap: _handleMenuButtonPressed,
                  child: const Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
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
                  }),
            ));
      },
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

  Future<void> _handleRefresh() async {
    // Implement your logic to fetch new data here
    // Update your HomeController state with the new data
    // Use setState inside GetBuilder to rebuild the UI
    await Future.delayed(const Duration(seconds: 2));
    Get.find<HomeController>();
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Lottie.asset('assets/lottie/nodata.json'),
    );
  }

  Widget _buildPostList() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return ListView.builder(
            itemCount: homeController.viewPostModel.data?.length ?? 5,
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
                          viewPostModel: homeController.viewPostModel,
                        ));
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Sizes.s16.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Sizes.s15.r),
                            child: homeController.viewPostModel.data?[index]
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
                                    homeController.viewPostModel.data?[index]
                                            .diamondImage ??
                                        'https://media.istockphoto.com/id/481365786/photo/diamond.jpg?s=612x612&w=0&k=20&c=niuZ5_KvgJrK08y-bjpXEsninUBf83ha-44_yrPmqpk=',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        ScreenUtil().setVerticalSpacing(15),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.s25.w),
                          child: Text(
                            formatTimeElapsed(homeController
                                    .viewPostModel.data?[index].createdAt ??
                                DateTime.now()),
                            style: AppTextStyle.smallTextStyle.copyWith(
                              color: AppColors.blackColor,
                              fontSize: Sizes.s16.sp,
                            ),
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
            if (homeController.viewPostModel.data?[index].buyerId?.isVerified ??
                false)
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
              if (homeController
                      .viewPostModel.data?[index].buyerId?.isVerified ??
                  false)
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

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
