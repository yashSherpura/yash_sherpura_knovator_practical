import 'package:flutter/material.dart';
import 'package:yash_practical/core/themes/themes.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.visible,
  });

  final String? text;

  final TextAlign textAlign;

  final TextStyle? textStyle;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      overflow: overflow,
      style: textStyle ?? TextStyles.normal(),
      textAlign: textAlign,
      maxLines: maxLines,
      // softWrap: true,
    );
  }
}
