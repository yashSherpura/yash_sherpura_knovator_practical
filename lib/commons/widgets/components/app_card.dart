import 'package:flutter/material.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/themes/themes.dart';

class AppCardWidget extends StatelessWidget {
  const AppCardWidget({
    required this.child,
    this.radius = Spacings.small,
    this.padding,
    this.margin,
    this.color = Palette.white,
    this.shadowColor,
    super.key,
  });

  final Widget child;
  final double radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (shadowColor ?? Palette.grey).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(Spacings.medium),
        child: child,
      ),
    );
  }
}
