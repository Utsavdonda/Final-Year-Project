import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/controller/home_controller.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/search/searchcategory/search_catgory_screen.dart';
import 'package:omni_market/widgets/size.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (searchScreenController) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  "Search",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.s18.sp),
                ),
              ),
              body: const SearchCatgoryScreen(),
            ),
          );
        });
  }
}
