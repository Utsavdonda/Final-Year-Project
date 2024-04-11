import 'dart:convert';

import 'package:omni_market/model/viewpost_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;
  static String userToken = "userToken";
  static String email = "email";
  static String profile = "profile";
  static String phone = "phone";
  static String role = "role";
  static String name = "name";
  static String isVerified = "isVerified";
  static String isLogin = "isLogin";
  static String userId = "userId";
  static String fcmToken = "ucmToken";
  static String seller_category = "seller_category";
  static String viewPostModelKey = "viewPostModel";

  static Future<void> setViewPostModel(ViewPostModel model, int index) async {
    String serializedModel = json.encode(model.data?[index].toJson());
    await sharedPreferences.setString(
        '$viewPostModelKey$index', serializedModel);
  }

  static ViewPostModel? getViewPostModel() {
    String? serializedModel = sharedPreferences.getString(viewPostModelKey);
    if (serializedModel != null) {
      Map<String, dynamic> json = jsonDecode(serializedModel);
      return ViewPostModel.fromJson(json);
    }
    return null;
  }
}
