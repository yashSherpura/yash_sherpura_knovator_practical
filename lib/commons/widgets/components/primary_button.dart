import 'package:flutter/material.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/themes/themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.enabledColor,
    this.onTap,
    this.label,
    this.disabledColor,
    this.padding = Spacings.large / 2,
    this.leading,
    this.trailing,
    this.textStyles,
    this.borderRadius = Spacings.large / 2,
    this.customPadding,
  });

  final Color? enabledColor;
  final Color? disabledColor;
  final VoidCallback? onTap;
  final String? label;
  final double? padding;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyles;
  final double borderRadius;
  final EdgeInsets? customPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            customPadding ?? EdgeInsets.all(padding!),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => states.contains(WidgetState.disabled)
                ? (disabledColor ?? Palette.grey)
                : enabledColor ?? Palette.primary,
          ),
          overlayColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) => Colors.white.withOpacity(0.4),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: () => onTap!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            leading ?? const Offstage(),
            if (leading != null)
              const SizedBox(
                width: Spacings.small,
              ),
            Flexible(
              child: Text(
                label!,
                style: textStyles ??
                    TextStyles.normal(
                      color: Palette.white,
                      fontWeight: FontConstants.bold,
                    ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            if (trailing != null)
              const SizedBox(
                width: Spacings.small,
              ),
            trailing ?? const Offstage(),
          ],
        ),
      ),
    );
  }
}

class PrimaryButtonRound extends StatelessWidget {
  const PrimaryButtonRound({
    super.key,
    this.enabledColor,
    this.onTap,
    this.label,
    this.disabledColor,
    this.padding = Spacings.small,
    this.leading,
    this.trailing,
    this.textStyles,
  });

  final Color? enabledColor;
  final Color? disabledColor;
  final VoidCallback? onTap;
  final String? label;
  final double? padding;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.all(padding!),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => states.contains(WidgetState.disabled)
                ? (disabledColor ?? Palette.grey)
                : enabledColor ?? Palette.primary,
          ),
          overlayColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) => Colors.white.withOpacity(0.4),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: enabledColor ?? Palette.primary),
            ),
          ),
        ),
        onPressed: () => onTap!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            leading ?? const Offstage(),
            Text(
              label!,
              style: textStyles ?? TextStyles.normal(color: Palette.white),
            ),
            trailing ?? const Offstage(),
          ],
        ),
      ),
    );
  }
}
