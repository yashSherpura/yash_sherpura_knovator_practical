class ApiResponseModel {
  ApiResponseModel({
    required this.success,
    this.apiResponse,
    this.error = '',
  });

  final bool success;
  final dynamic apiResponse;
  final String error;
}
