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

abstract class UpdateUserRepository {
  Future<Either<ApiError, Map<String, dynamic>>> updateUser(
      context, Map<String, dynamic>? data);
}

class UpdateUserImplementation implements UpdateUserRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Map<String, dynamic>>> updateUser(
      context, Map<String, dynamic>? data) async {
    try {
      Loader.show(context);
      var response = await (await _apiService.getDioClient())
          .patch(APIEndpoints.updateProfile, data: data);
      if (response.statusCode == 200) {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? fcmToken = await messaging.getToken();
        switch (response.data['data']['role']) {
          case 'seller':
            LocalStorage.sharedPreferences.setBool(LocalStorage.isLogin, true);

            LocalStorage.sharedPreferences
                .setString(LocalStorage.email, response.data['data']['email']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.userId, response.data['data']['_id']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.profile, response.data['data']['profile']);
            LocalStorage.sharedPreferences.setStringList(
                LocalStorage.seller_category,
                response.data['data']['seller_category']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.phone, response.data['data']['contact']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.name, response.data['data']['name']);
            LocalStorage.sharedPreferences.setString(LocalStorage.fcmToken,
                fcmToken ?? response.data['data']['fcm_token']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.role, response.data['data']['role']);
            Loader.dismiss(context);
            navigationPushAndRemoveUntil(context, const SellerBottomBar());
            return Right(response.data);
          case 'buyer':
            LocalStorage.sharedPreferences.setBool(LocalStorage.isLogin, true);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.email, response.data['data']['email']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.userId, response.data['data']['_id']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.profile, response.data['data']['profile']);
            LocalStorage.sharedPreferences.setString(LocalStorage.fcmToken,
                fcmToken ?? response.data['data']['fcm_token']);
            LocalStorage.sharedPreferences.setString(
                LocalStorage.phone, response.data['data']['contact']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.name, response.data['data']['name']);
            LocalStorage.sharedPreferences
                .setString(LocalStorage.role, response.data['data']['role']);
            Loader.dismiss(context);
            navigationPushAndRemoveUntil(context, const BuyerBottomBar());
            return Right(response.data);
          default:
            Loader.dismiss(context);
            return Right(response.data);
        }
      } else {
        Loader.dismiss(context);
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      Loader.dismiss(context);
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
