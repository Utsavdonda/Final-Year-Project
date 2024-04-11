import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/model/all_seller_model.dart';
import 'package:omni_market/utils/api_services.dart';

import '../../utils/api_error.dart';

abstract class ViewAllSellerRepository {
  Future<Either<ApiError, AllSellerModel>> viewAllSellers();
}

class ViewAllSellerImplementation implements ViewAllSellerRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, AllSellerModel>> viewAllSellers() async {
    try {
      var response =
          await (await _apiService.getDioClient()).get(APIEndpoints.allSeller);
      print(response.data.runtimeType);
      if (response.statusCode == 200) {
        final AllSellerModel viewPostsModel =
            AllSellerModel.fromJson(response.data as Map<String, dynamic>);
        return Right(viewPostsModel);
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
