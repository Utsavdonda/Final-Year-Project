import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/model/view_post_bid_model.dart';
import 'package:omni_market/utils/api_services.dart';

import '../../utils/api_error.dart';

abstract class ViewBidRepository {
  Future<Either<ApiError, ViewPostsBidModel>> viewBids(data);
}

class ViewBidImplementation implements ViewBidRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, ViewPostsBidModel>> viewBids(data) async {
    try {
      var response = await (await _apiService.getDioClient())
          .post(APIEndpoints.viewBid, data: data);
      print(response.data.runtimeType);

      if (response.statusCode == 200) {
        final ViewPostsBidModel viewPostBidModel =
            ViewPostsBidModel.fromJson(response.data as Map<String, dynamic>);
        return Right(viewPostBidModel);
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
