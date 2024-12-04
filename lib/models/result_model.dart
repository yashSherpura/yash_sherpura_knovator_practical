class ResultModel {
  const ResultModel({
    required this.success,
    this.message,
    this.statusCode,
    this.result,
  });

  final bool success;
  final String? message;
  final int? statusCode;
  final dynamic result;
}
