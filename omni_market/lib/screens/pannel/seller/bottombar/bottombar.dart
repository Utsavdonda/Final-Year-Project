import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/controller/bottombar_controler.dart';
import 'package:omni_market/widgets/size.dart';

// ignore: must_be_immutable
class SellerBottomBar extends StatefulWidget {
  const SellerBottomBar({super.key});

  @override
  State<SellerBottomBar> createState() => _SellerBottomBarState();
}

class _SellerBottomBarState extends State<SellerBottomBar> {
  BottomBarController controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomBarController>(
        builder: (controller) {
          return controller.sellerScreens[controller.sellerSelectedIndex];
        },
      ),
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
                horizontal: Sizes.s5.w, vertical: Sizes.s8.w),
            child: GNav(
              rippleColor: AppColors.primaryColor,
              hoverColor: AppColors.primaryColor,
              gap: 8,
              activeColor: AppColors.whiteColor,
              iconSize: Sizes.s24.sp,
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s20.w, vertical: Sizes.s12.w),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  iconColor: AppColors.greyColor,
                  text: 'Deals',
                ),
                GButton(
                  icon: Icons.search,
                  iconColor: AppColors.greyColor,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.assignment,
                  iconColor: AppColors.greyColor,
                  text: 'Contracts',
                ),
              ],
              selectedIndex: controller.sellerSelectedIndex,
              onTabChange: (index) {
                controller.sellerSelectedIndex = index;
                controller.update();
              },
            ),
          ),
        ),
      ),
    );
  }
}
