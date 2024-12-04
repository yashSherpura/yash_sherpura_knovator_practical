import 'dart:developer';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/themes/themes.dart';

class Utility {
  static void showLog(String value, {String key = 'Result'}) {
    if (kDebugMode) {
      log('$key : $value');
    }
  }

  static void showCenterFlash({
    required String message,
    FlashPosition position = FlashPosition.top,
    FlashBehavior style = FlashBehavior.floating,
    bool isIcon = false,
    bool isSuccess = false,
    int duration = 3,
    GlobalKey? key,
    required BuildContext context,
  }) {
    context.showFlash(
      duration: Duration(seconds: duration),
      barrierDismissible: true,
      builder: (BuildContext _, FlashController<dynamic> controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flash<dynamic>(
              controller: controller,
              position: FlashPosition.bottom,
              child: Padding(
                padding: const EdgeInsets.all(Spacings.xLarge),
                child: Wrap(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: isSuccess ? Palette.successBg : Palette.errorBg,
                      ),
                      padding: const EdgeInsets.all(Spacings.large / 2),
                      margin: const EdgeInsets.only(bottom: Spacings.xxxxLarge),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (isSuccess)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.done_outline),
                            ),
                          Flexible(
                            child: TextLabel(
                              text: message,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              textStyle: TextStyles.normalMedium(
                                color: isSuccess
                                    ? Palette.successText
                                    : Palette.errorText,
                                fontFamily: StringConstants.fontName,
                                fontWeight: FontConstants.medium,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
