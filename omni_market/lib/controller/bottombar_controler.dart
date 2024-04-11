import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/contract/contract.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/home/buyer_home.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/yourposts/your_post.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/contract/contractscreen.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/homescreen.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/search/search_screen.dart';

class BottomBarController extends GetxController {
  int sellerSelectedIndex = 0;
  int buyerSelectedIndex = 0;
  List<Widget> sellerScreens = [
    HomeScreen(),
    const SearchScreen(),
    const SellerContractScreen(),
  ];
  List<Widget> buyerScreens = [
    BuyerHomeScreen(),
    YourPostsScreen(),
    const BuyerContractScreen()
  ];

  void changeTabIndexSeller(int index) {
    sellerSelectedIndex = index;
    update();
  }

  void changeTabIndexBuyer(int index) {
    buyerSelectedIndex = index;
    update();
  }
}
