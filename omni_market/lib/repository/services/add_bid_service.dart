import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/bottombar.dart';
import 'package:omni_market/utils/api_services.dart';
import 'package:omni_market/widgets/loader.dart';
import 'package:omni_market/widgets/navigation.dart';

import '../../utils/api_error.dart';

abstract class AddBidRepository {
  Future<Either<ApiError, Map<String, dynamic>>> addBids(
      Map<String, dynamic> data, context);
}

class AddBidImplementation implements AddBidRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Map<String, dynamic>>> addBids(
      Map<String, dynamic> data, context) async {
    try {
      Loader.show(context);
      var response = await (await _apiService.getDioClient())
          .post(APIEndpoints.addBid, data: data);
      if (response.statusCode == 200) {
        
        navigationPushAndRemoveUntil(context, const SellerBottomBar());
        return Right(response.data);
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
