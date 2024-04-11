import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/model/viewpost_model.dart';
import 'package:omni_market/utils/api_services.dart';

import '../../utils/api_error.dart';

abstract class ViewPostRepository {
  Future<Either<ApiError, Either<Map<String, dynamic>, ViewPostModel>>>
      viewPosts();
}

class ViewPostsImplementation implements ViewPostRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Either<Map<String, dynamic>, ViewPostModel>>>
      viewPosts() async {
    try {
      var response = await (await _apiService.getDioClient())
          .post(APIEndpoints.viewPosts, data: {
        "buyer_id":
            LocalStorage.sharedPreferences.getString(LocalStorage.userId)
      });
      print(response.data.runtimeType);
      if (response.statusCode == 200) {
        if (response.data['message'] == "Data not found") {
          Right(Left(response.data));
        } else {
          final ViewPostModel viewPostsModel =
              ViewPostModel.fromJson(response.data as Map<String, dynamic>);
          return Right(Right(viewPostsModel));
        }
        return Right(Left(response.data));
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
