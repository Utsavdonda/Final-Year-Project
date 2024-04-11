import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/model/view_diamond.dart';
import 'package:omni_market/utils/api_services.dart';

import '../../utils/api_error.dart';

abstract class ViewDiamondRepository {
  Future<Either<ApiError, ViewDiamondModel>> viewDiamonds();
}

class ViewDiamondImplementation implements ViewDiamondRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, ViewDiamondModel>> viewDiamonds() async {
    try {
      var response = await (await _apiService.getDioClient())
          .get(APIEndpoints.viewDiamond);
      if (response.statusCode == 200) {
        final ViewDiamondModel viewDiamondModel =
            ViewDiamondModel.fromJson(response.data as Map<String, dynamic>);
        return Right(viewDiamondModel);
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
