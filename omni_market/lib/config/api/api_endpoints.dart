import 'env_constants.dart';

enum Flavor { develop, qa, staging, production, local }

class APIEndpoints {
  const APIEndpoints._();

  static String get appApiBaseUrl {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return 'https://omni-market-2hzl.onrender.com/';
      case Flavor.qa:
        return 'BaseUrl';
      case Flavor.staging:
        return 'BaseUrl';
      case Flavor.production:
        return 'BaseUrl';
      case Flavor.local:
        return 'http://192.168.31.102:8080/';
    }
  }

  static String admin = "admin/";
  static String viewDiamond = "$appApiBaseUrl${admin}viewDiamond";
  static String allSeller = "$appApiBaseUrl${admin}allSeller";
  static String addPost = "${appApiBaseUrl}add-posts";

  static String loginClient = "${appApiBaseUrl}login-client";
  static String addClient = "${appApiBaseUrl}add-client";
  static String updateProfile = "${appApiBaseUrl}update-profile";
  static String otpVerify = "${appApiBaseUrl}otpverify";
  static String viewPosts = "${appApiBaseUrl}view-posts";
  static String addBid = "${appApiBaseUrl}add-bid";
  static String viewBid = "${appApiBaseUrl}view-bid-post";
  static String addContract = "${appApiBaseUrl}add-contract";
  static String viewContract = "${appApiBaseUrl}view-contract";
  static String addSubscription = "${appApiBaseUrl}add-subscription";
  static String deletePosts = "${appApiBaseUrl}delete-posts";
  static String deleteBid = "${appApiBaseUrl}delete-bid";
  static String addFeedBack = "${appApiBaseUrl}add-review";
}
