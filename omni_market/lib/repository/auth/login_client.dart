import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/bottom_bar.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/bottombar.dart';
import 'package:omni_market/utils/api_services.dart';
import 'package:omni_market/widgets/loader.dart';
import 'package:omni_market/widgets/navigation.dart';

import '../../utils/api_error.dart';

abstract class LoginClientRepository {
  Future<Either<ApiError, Map<String, dynamic>>> loginUser(context, data);
}

class LoginClientImplementation implements LoginClientRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Map<String, dynamic>>> loginUser(
      context, data) async {
    try {
      Loader.show(context);
      var response = await (await _apiService.getDioClient())
          .get(APIEndpoints.loginClient, data: data);
      if (response.statusCode == 200) {
        List<dynamic> sellerCategoryDynamic =
            response.data['data'][0]['seller_category'];
        List<String> sellerCategory =
            sellerCategoryDynamic.map((item) => item.toString()).toList();
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? fcmToken = await messaging.getToken();
        switch (response.data['data'][0]['role']) {
          case 'seller':
            LocalStorage.sharedPreferences.setBool(LocalStorage.isLogin, true);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.userToken, response.data['token']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.role, 'seller');
            LocalStorage.sharedPreferences
                .setStringList(LocalStorage.seller_category, sellerCategory);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.userId, response.data['data'][0]['_id']);
            LocalStorage.sharedPreferences.setBool(LocalStorage.isVerified,
                response.data['data'][0]['isVerified']);
            LocalStorage.sharedPreferences.setString(LocalStorage.fcmToken,
                fcmToken ?? response.data['data'][0]['fcm_token']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.email, response.data['data'][0]['email']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.name, response.data['data'][0]['name']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.phone, response.data['data'][0]['contact']);

            Loader.dismiss(context);
            navigationPushAndRemoveUntil(context, const SellerBottomBar());
            return Right(response.data);
          case 'buyer':
            LocalStorage.sharedPreferences.setBool(LocalStorage.isLogin, true);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.userToken, response.data['token']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.role, 'buyer');
            LocalStorage.sharedPreferences.setBool(LocalStorage.isVerified,
                response.data['data'][0]['isVerified']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.userId, response.data['data'][0]['_id']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.email, response.data['data'][0]['email']);
            LocalStorage.sharedPreferences.setString(LocalStorage.fcmToken,
                fcmToken ?? response.data['data'][0]['fcm_token']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.name, response.data['data'][0]['name']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.phone, response.data['data'][0]['contact']);
            Loader.dismiss(context);
            navigationPushAndRemoveUntil(context, const BuyerBottomBar());
            return Right(response.data);
          default:
            Loader.dismiss(context);
            return Right(response.data);
        }
      } else {
        Loader.dismiss(context);
        log("message error");
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      Loader.dismiss(context);
      log("$error");
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
