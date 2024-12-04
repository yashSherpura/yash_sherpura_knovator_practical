import 'package:yash_practical/core/constants/constants.dart';

class ErrorModel {
  ErrorModel({
    this.code,
    this.message,
    this.reason,
    this.error,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json[ApiConstants.keyCode] as int,
        message: json[ApiConstants.keyMessage].toString(),
        reason: json[ApiConstants.keyReason] == null
            ? ''
            : json[ApiConstants.keyReason].toString(),
        error: json[ApiConstants.keyError] == null
            ? ''
            : json[ApiConstants.keyError].toString(),
      );

  int? code;
  String? message;
  String? reason;
  String? error;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiConstants.keyCode: code,
      ApiConstants.keyMessage: message,
      ApiConstants.keyReason: reason,
      ApiConstants.keyError: error,
    };
  }
}
