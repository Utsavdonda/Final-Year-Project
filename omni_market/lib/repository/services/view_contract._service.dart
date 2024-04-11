import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/model/view_contract_model.dart';
import 'package:omni_market/utils/api_services.dart';

import '../../utils/api_error.dart';

abstract class ViewContractRepostiory {
  Future<Either<ApiError, Either<Map<String, dynamic>, ViewContractModel>>>
      viewContract();
}

class ViewContractImplementation implements ViewContractRepostiory {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Either<Map<String, dynamic>, ViewContractModel>>>
      viewContract() async {
    try {
      var response = await (await _apiService.getDioClient()).post(
          APIEndpoints.viewContract,
          data: LocalStorage.sharedPreferences.getString(LocalStorage.role) ==
                  'seller'
              ? {
                  'seller_id': LocalStorage.sharedPreferences
                      .getString(LocalStorage.userId),
                }
              : {
                  'buyer_id': LocalStorage.sharedPreferences
                      .getString(LocalStorage.userId),
                });
      if (response.statusCode == 200) {
        if (response.data['message'] == "Data not found") {
          Right(Left(response.data));
        } else {
          final ViewContractModel viewContractModel =
              ViewContractModel.fromJson(response.data as Map<String, dynamic>);
          print("data is filled");
          return Right(Right(viewContractModel));
        }
        return Right(Left(response.data));
      } else {
        return Left(ApiError(error: "Something went wrong"));
      }
    } catch (error) {
      print("================================================${error}");
      return Left(ApiError(error: "Something went wrong"));
    }
  }
}
