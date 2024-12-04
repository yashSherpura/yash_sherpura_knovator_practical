import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:yash_practical/commons/widgets/components/error_view.dart';
import 'package:yash_practical/core/constants/string_constants.dart';
import 'package:yash_practical/core/utility/utility.dart';

String mapError(
  dynamic e,
) {
  if (e is DioError) {
    return mapDioError(e) ?? errorErrorView;
  } else if (e is PlatformException) {
    return e.message ?? errorErrorView;
  } else if (e is SocketException) {
    return errorNoInternet;
  }
  return e.toString();
}

String? mapDioError(DioError error) {
  String? errorMsg;
  if (error.response != null) {
    final dynamic responseData = error.response?.data;
    if (responseData is Map) {
      try {
        final Map<String, dynamic> errorMap =
            responseData.cast<String, dynamic>();
        final ApiError apiError = ApiError.fromMap(errorMap);
        apiError.statusCode = error.response?.statusCode;
        if (apiError.error != null &&
            apiError.error!.toLowerCase() ==
                StringConstants.errorUserNotFound) {
          errorMsg = StringConstants.errorUserNotFound;
        } else if (apiError.message != null) {
          errorMsg = apiError.message;
        }
      } catch (e) {
        Utility.showLog('e:$e');
      }
    }
  } else if (error.runtimeType == SocketException ||
      error.runtimeType == HttpException) {
    errorMsg = errorNoInternet;
  } else if (error.type == DioErrorType.cancel) {
    errorMsg = errorCancel;
  } else if (error.type == DioErrorType.connectTimeout) {
    errorMsg = errorTimeOut;
  } else if (error.type == DioErrorType.other) {
    errorMsg = error.message;
  } else if (error.type == DioErrorType.receiveTimeout) {
    errorMsg = errorReceiveTimeOut;
  } else if (error.type == DioErrorType.response) {
    errorMsg = 'Received invalid status code: ${error.response?.statusCode}';
  } else if (error.type == DioErrorType.sendTimeout) {
    errorMsg = errorSendTimeOUT;
  }
  return errorMsg;
}

class ApiError {
  ApiError(this.message, this.error, this.statusCode);

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      map['message'] as String?,
      map['error'] as String?,
      map['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'error': error,
        'statusCode': statusCode,
      };

  final String? message;
  final String? error;
  int? statusCode;
}
