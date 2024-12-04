import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components/primary_button.dart';
import 'package:yash_practical/commons/widgets/components/text_label.dart';
import 'package:yash_practical/core/constants/spacings.dart';
import 'package:yash_practical/core/themes/palette.dart';
import 'package:yash_practical/core/themes/text_styles.dart';

enum ErrorType { noInternet, error, noData }

const String labelReconnect = 'Reconnect';
const String labelRefresh = 'Refresh';
const String errorNoInternet = 'No Internet';
const String errorNoData = 'No data found';
const String errorErrorView = 'Technical Error';
const String msgNoInternetConnection =
    "You don't seem to have an active internet connection. "
    'Please check your connection and try again.';
const String msgNoData =
    'Result which you are looking for is not available currently';
const String msgErrorView =
    "Something went wrong\nSorry, we're having some technical issue here, "
    'Try to refresh the page';
const String errorCancel = 'Request to API server was cancelled';
const String errorTimeOut = 'Connection timeout with API server';
const String errorReceiveTimeOut =
    'Receive timeout in connection with API server';
const String errorSendTimeOUT = 'Send timeout in connection with API server';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.height,
    this.width,
    required this.onReconnect,
    required this.errorType,
    this.buttonText,
    this.errorMsg,
    this.errorTitle,
    this.isShowRefreshButton = true,
    this.showIcon = true,
    this.allowHeightNullable = false,
  });

  static Key errorViewWidgetReconnectButtonKey =
      const Key('ErrorViewWidget-reconnect-button');

  final double? height;
  final double? width;
  final Function onReconnect;
  final ErrorType errorType;
  final String? errorTitle;
  final String? buttonText;
  final String? errorMsg;
  final bool isShowRefreshButton;
  final bool showIcon;
  final bool allowHeightNullable;

  @override
  Widget build(BuildContext context) {
    late Widget image;
    late String msg;
    late String errorTitle;
    late String buttonText;

    switch (errorType) {
      case ErrorType.noInternet:
        image = const Icon(Icons.signal_cellular_connected_no_internet_4_bar,
            size: 100);
        msg = msgNoInternetConnection;
        buttonText = labelReconnect;
        errorTitle = errorNoInternet;
        break;
      case ErrorType.error:
        image = const Icon(Icons.no_adult_content_rounded, size: 100);
        msg = msgErrorView;
        buttonText = labelRefresh;
        errorTitle = errorErrorView;
        break;
      case ErrorType.noData:
        image = const Icon(Icons.no_backpack, size: 100);
        msg = msgNoData;
        buttonText = labelRefresh;
        errorTitle = errorNoData;
        break;
      default:
        image = const Icon(Icons.signal_cellular_connected_no_internet_4_bar,
            size: 100);
        msg = msgErrorView;
        buttonText = labelRefresh;
        errorTitle = errorErrorView;
        break;
    }

    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (showIcon)
                  Expanded(
                    flex: MediaQuery.of(context).viewInsets.bottom == 0 ? 5 : 0,
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? Spacings.large
                            : Spacings.small,
                      ),
                      child: image,
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? Spacings.medium
                      : 0,
                ),
                Expanded(
                  child: TextLabel(
                    textAlign: TextAlign.center,
                    text: this.errorTitle ?? errorTitle,
                    textStyle: TextStyles.titleMedium(
                      size: Spacings.xLarge,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Spacings.medium,
                ),
                Expanded(
                  child: TextLabel(
                    textAlign: TextAlign.center,
                    text: errorMsg ?? msg,
                    textStyle: TextStyles.normal(
                      color: Palette.grey,
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: Spacings.xLarge,
                ),
                if (isShowRefreshButton)
                  PrimaryButton(
                    key: errorViewWidgetReconnectButtonKey,
                    onTap: () {
                      onReconnect();
                    },
                    label: this.buttonText ?? buttonText,
                  ),
                if (isShowRefreshButton)
                  const SizedBox(
                    height: Spacings.xLarge,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
