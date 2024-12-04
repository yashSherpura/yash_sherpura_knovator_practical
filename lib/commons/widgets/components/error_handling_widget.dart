import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components/error_view.dart';
import 'package:yash_practical/core/errors.dart';

class ErrorHandlingWidget extends StatelessWidget {
  const ErrorHandlingWidget({
    required this.errorObject,
    required this.onReconnect,
    this.height,
    super.key,
  });

  final Object? errorObject;
  final Function onReconnect;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final String error = mapError(errorObject);
    return Center(
      child: ErrorView(
        onReconnect: onReconnect,
        width: MediaQuery.sizeOf(context).width * 0.85,
        height: height,
        errorMsg: error.compareTo(
                  errorNoInternet,
                ) ==
                0
            ? null
            : error,
        errorType: error.compareTo(
                  errorNoInternet,
                ) ==
                0
            ? ErrorType.noInternet
            : ErrorType.error,
      ),
    );
  }
}
