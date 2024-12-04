import 'package:flutter/material.dart';
import 'package:yash_practical/core/constants/font_constants.dart';
import 'package:yash_practical/core/themes/palette.dart';

class TextStyles {
  static TextStyle title({
    Color? color = Palette.colorTextDark,
    FontWeight fontWeight = FontConstants.bold,
    double size = FontConstants.fontSizeLarge,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle titleMedium({
    Color? color = Palette.colorTextDark,
    FontWeight fontWeight = FontConstants.bold,
    double size = FontConstants.fontSizeNormal,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      );

  static TextStyle normal({
    Color? color = Palette.colorTextDark,
    FontWeight fontWeight = FontConstants.medium,
    double size = FontConstants.fontSizeNormal,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle normalMedium({
    Color? color = Palette.colorTextDark,
    FontWeight fontWeight = FontConstants.regular,
    double size = FontConstants.fontSizeNormalMedium,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );
}
