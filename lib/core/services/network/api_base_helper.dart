import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yash_practical/core/constants/api_constants.dart';
import 'package:yash_practical/core/constants/string_constants.dart';
import 'package:yash_practical/core/utility/utility.dart';
import 'package:yash_practical/models/api_response_model.dart';
import 'package:yash_practical/models/error_model.dart';

class ApiBaseHelper {
  Future<ApiResponseModel> get({
    required String api,
    String? authKey,
  }) async {
    try {
      Response<dynamic> response;
      final String baseUrl = ApiConstants.baseUrl;
      if (authKey != null) {
        if (authKey.isNotEmpty) {
          response = await Dio().get(
            '$baseUrl$api',
            options: Options(),
          );
        } else {
          final Map<String, String> headers = <String, String>{
            ApiConstants.keyContentType:
                ApiConstants.keyContentTypeApplicationJson,
          };
          response = await Dio().get(
            '$baseUrl$api',
            options: Options(headers: headers),
          );
        }
      } else {
        final Map<String, String> headers = <String, String>{
          ApiConstants.keyContentType:
              ApiConstants.keyContentTypeApplicationJson,
        };
        response = await Dio().get(
          '$baseUrl$api',
          options: Options(headers: headers),
        );
      }

      final dynamic responseJson = response.data;
      Utility.showLog('API Response ${'$baseUrl$api'}: $responseJson');
      return ApiResponseModel(
        success: true,
        apiResponse: responseJson,
      );
    } on SocketException {
      return ApiResponseModel(
        success: false,
        error: StringConstants.msgNoInternet,
      );
    } on DioError catch (e) {
      return dioErrorMsg(e);
    } catch (e) {
      Utility.showLog('Error in Calling (API) $api: ${e.toString()}');
      return ApiResponseModel(
        success: false,
        error: e.toString(),
      );
    }
  }

  ApiResponseModel dioErrorMsg(DioError e) {
    if (e.response?.statusCode == 401) {
      return ApiResponseModel(
        success: false,
        error: StringConstants.errorUnauthorizedToken,
      );
    }
    if (e.response != null) {
      if (e.response!.data != null) {
        final dynamic responseData = e.response?.data;
        if (responseData is Map) {
          try {
            final Map<String, dynamic> errorMap =
                responseData.cast<String, dynamic>();
            final ErrorModel apiError = ErrorModel.fromJson(errorMap);
            apiError.code = e.response?.statusCode;
            return ApiResponseModel(
              success: false,
              error: apiError.message ?? StringConstants.msgSomethingWentWrong,
            );
          } catch (ex) {
            Utility.showLog('e:$ex');
            return ApiResponseModel(
              success: false,
              error: ex.toString(),
            );
          }
        } else {
          if (e.response!.statusCode == 403) {
            return ApiResponseModel(
              success: false,
              error: StringConstants.msgUnauthorised,
            );
          } else if (e.response!.statusCode == 400) {
            return ApiResponseModel(
              success: false,
              error: e.response!.statusMessage.toString(),
            );
          } else if (e.response!.statusCode == 500) {
            return ApiResponseModel(
              success: false,
              error: e.response!.statusMessage.toString(),
            );
          } else if (e.response!.statusCode == 404) {
            return ApiResponseModel(
              success: false,
              error: StringConstants.msgPageNotFound,
            );
          } else {
            return ApiResponseModel(
              success: false,
              error: StringConstants.msgSomethingWentWrong,
            );
          }
        }
      } else {
        return ApiResponseModel(
          success: false,
          error: StringConstants.msgSomethingWentWrong,
        );
      }
    } else {
      Utility.showLog('Error in api call (base_helper) : ${e.message}');
      return ApiResponseModel(
        success: false,
        error: StringConstants.msgSomethingWentWrong,
      );
    }
  }
}
