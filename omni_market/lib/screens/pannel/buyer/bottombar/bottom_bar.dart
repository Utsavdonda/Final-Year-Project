import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/controller/bottombar_controler.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/addpost/add_post.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';

// ignore: must_be_immutable
class BuyerBottomBar extends StatefulWidget {
  const BuyerBottomBar({super.key});

  @override
  State<BuyerBottomBar> createState() => _BuyerBottomBarState();
}

class _BuyerBottomBarState extends State<BuyerBottomBar> {
  final BottomBarController controller = Get.put(BottomBarController());
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
        init: BottomBarController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              enableFeedback: true,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.add,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                navigationPush(
                  context,
                  const AddPostScreen(),
                );
              },
            ),
            body: controller.buyerScreens[_selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s15.w, vertical: Sizes.s8.h),
                  child: GNav(
                    rippleColor: AppColors.primaryColor,
                    hoverColor: AppColors.primaryColor,
                    gap: 8,
                    activeColor: AppColors.whiteColor,
                    iconSize: Sizes.s24.sp,
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.s20.w, vertical: Sizes.s12.h),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: AppColors.primaryColor,
                    color: Colors.black,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        iconColor: AppColors.greyColor,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.price_change,
                        iconColor: AppColors.greyColor,
                        text: 'Your Posts',
                      ),
                      GButton(
                        icon: Icons.payment,
                        iconColor: AppColors.greyColor,
                        text: 'Contract',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
