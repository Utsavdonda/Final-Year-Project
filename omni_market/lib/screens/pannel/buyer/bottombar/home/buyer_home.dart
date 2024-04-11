import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/controller/buyer_homescreen_controller.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/repository/services/add_review.dart';
import 'package:omni_market/screens/auth/login_screen.dart';
import 'package:omni_market/screens/auth/user_details_screen.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/home/subscription/buyer_subscription_screen.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/common/skill_chip.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyerHomeScreen extends StatelessWidget {
  BuyerHomeScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController shareExperienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? name = LocalStorage.sharedPreferences.getString(LocalStorage.name);
    String? email =
        LocalStorage.sharedPreferences.getString(LocalStorage.email);
    String? photo =
        LocalStorage.sharedPreferences.getString(LocalStorage.profile);
    return AdvancedDrawer(
        backdrop: const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
        controller: _advancedDrawerController,
        childDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s16.r)),
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name ?? 'User Name'),
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
                    navigationPush(context, BuyerSubscriptionsScreen());
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
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) {
                                    HomeController homeController =
                                        Get.find<HomeController>();
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
                                    borderRadius: BorderRadius.circular(10)),
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
                                HomeController homeController =
                                    Get.find<HomeController>();
                                AddReviewImplementation().addReview(context, {
                                  "client_id": LocalStorage.sharedPreferences
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
                                    borderRadius: BorderRadius.circular(10)),
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
                                await LocalStorage.sharedPreferences.clear();
                                navigationPushAndRemoveUntil(
                                    context, const LoginScreen());
                              },
                              child: Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
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
                                    borderRadius: BorderRadius.circular(10)),
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
              title:
                  LocalStorage.sharedPreferences.getString(LocalStorage.name) ??
                      '',
              isDrawer: true,
              elevation: 0,
              drawerTrigger: InkWell(
                  onTap: _handleMenuButtonPressed,
                  child: const Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                  )),
            ),
            body: GetBuilder<BuyerHomeScreenController>(
                init: BuyerHomeScreenController(),
                builder: (buyerHomescreencontroller) {
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                      itemCount: buyerHomescreencontroller
                              .allSellerModel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Sizes.s100.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.greyColor.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(3, 3)),
                              BoxShadow(
                                  color: AppColors.blackColor.withOpacity(0),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1)),
                            ],
                            borderRadius: BorderRadius.circular(Sizes.s15.r),
                          ),
                          margin: EdgeInsets.symmetric(vertical: Sizes.s10.h),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ScreenUtil().setVerticalSpacing(15),
                                  Row(
                                    children: [
                                      Text(
                                          buyerHomescreencontroller
                                                  .allSellerModel
                                                  .data?[index]
                                                  .name ??
                                              '',
                                          style: AppTextStyle.mediumTextStyle
                                              .copyWith(
                                            color: AppColors.blackColor,
                                            fontSize: Sizes.s24.sp,
                                          )),
                                      width15,
                                      const Icon(Icons.verified_sharp,
                                          color: Colors.blue),
                                      const Spacer(),
                                      RatingBar.builder(
                                        initialRating: 3.5,
                                        itemSize: Sizes.s20.sp,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: AppColors.primaryColor,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ],
                                  ),
                                  ScreenUtil().setVerticalSpacing(10),
                                  Row(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Wrap(
                                          children: List.generate(
                                              buyerHomescreencontroller
                                                      .allSellerModel
                                                      .data?[index]
                                                      .sellerCategory
                                                      ?.length ??
                                                  0, (index1) {
                                            return SkillChip(
                                                skill: buyerHomescreencontroller
                                                            .allSellerModel
                                                            .data?[index]
                                                            .sellerCategory?[
                                                        index1] ??
                                                    '');
                                          }),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () async {
                                            final Uri launchUri = Uri(
                                              scheme: 'tel',
                                              path: buyerHomescreencontroller
                                                      .allSellerModel
                                                      .data?[index]
                                                      .contact ??
                                                  '',
                                            );
                                            await launchUrl(launchUri);
                                          },
                                          icon: const Icon(Icons.phone)),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      });
                })));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
