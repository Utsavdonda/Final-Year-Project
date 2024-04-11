import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/screens/pannel/buyer/bottombar/bottom_bar.dart';
import 'package:omni_market/utils/api_services.dart';
import 'package:omni_market/widgets/loader.dart';
import 'package:omni_market/widgets/navigation.dart';

import '../../utils/api_error.dart';

abstract class AddPostRepository {
  Future<Either<ApiError, Map<String, dynamic>>> addPosts(
      Map<String, dynamic> data, context);
}

class AddPostImplementation implements AddPostRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Map<String, dynamic>>> addPosts(
      Map<String, dynamic> data, context) async {
    try {
      Loader.show(context);
      var response = await (await _apiService.getDioClient())
          .post(APIEndpoints.addPost, data: data);
      if (response.statusCode == 200) {
        Loader.dismiss(context);
        navigationPushAndRemoveUntil(context, const BuyerBottomBar());
        return Right(response.data);
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
