import 'package:dartz/dartz.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/screens/auth/otp_verification.dart';
import 'package:omni_market/utils/api_services.dart';
import 'package:omni_market/widgets/loader.dart';
import 'package:omni_market/widgets/navigation.dart';

import '../../utils/api_error.dart';

abstract class AddUserRepository {
  Future<Either<ApiError, Map<String, dynamic>>> addUser(
      context, data, verifyData);
}

class AddUserImplementation implements AddUserRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<Either<ApiError, Map<String, dynamic>>> addUser(
      context, data, verifyData) async {
    try {
      Loader.show(context);
      var response = await (await _apiService.getDioClient())
          .post(APIEndpoints.addClient, data: data);
      if (response.statusCode == 200) {
        Loader.dismiss(context);
        navigationPush(
            context,
            OtpVerificationPage(
              email: data['email'],
              verifyData: verifyData,
            ));
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
