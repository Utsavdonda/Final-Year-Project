import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/screens/auth/login_screen.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/bottom_bar.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/bottombar.dart';
import 'package:omni_market/widgets/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (LocalStorage.sharedPreferences.getBool(LocalStorage.isLogin) ==
          true) {
        if (LocalStorage.sharedPreferences
                .getString(LocalStorage.role)
                .toString() ==
            "buyer") {
          navigationPushAndRemoveUntil(context, const BuyerBottomBar());
        } else {
          navigationPushAndRemoveUntil(context, const SellerBottomBar());
        }
      } else {
        navigationPushAndRemoveUntil(context, const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Lottie.asset("assets/lottie/splash.json")),
    );
  }
}
