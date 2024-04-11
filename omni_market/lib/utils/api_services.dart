import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:omni_market/config/api/api_endpoints.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class ApiService {
  Future<Dio> getDioClient() async {
    final Dio dio = Dio();
    try {
      String langCode = "";
      String? userAccessToken =
          LocalStorage.sharedPreferences.getString(LocalStorage.userToken);
      print("object $userAccessToken");
      dio
        ..options.headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "authentication": "$userAccessToken",
          "lcode": langCode,
        })
        ..interceptors.clear()
        ..options.baseUrl = APIEndpoints.appApiBaseUrl;
      if (kReleaseMode == false) {
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        );
      }
      if (!kIsWeb) {
        // ignore: deprecated_member_use
        (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
            (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
      }
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
            options.headers = {
              'Content-Type': 'application/json;charset=UTF-8',
              "authentication": "$userAccessToken",
            };
            options.baseUrl = APIEndpoints.appApiBaseUrl;
            return handler.next(options);
          },
          onResponse: (Response response, handler) {
            return handler.next(response);
          },
          onError: (error, handler) {
            if (error.response != null) {
              if (error.response!.statusCode != null &&
                  error.response!.statusCode != 401) {
                // FirebaseCrashlytics.instance.recordError(
                //     error, StackTrace.fromString(error.response.toString()));
                // Catcher.reportCheckedError(error, error.response);
              } else {
                print("====123$error");
              }
            }
            return handler.next(error);
          },
        ),
      );
    } catch (e) {
      log(e.toString(), name: "ApiService");
    }

    return dio;
  }
}
