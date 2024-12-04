import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/themes/themes.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.title,
    this.onLeadingPress,
    this.isShowBackButton = false,
    this.actions,
    this.titleMaxLine = 1,
    this.prefixIcon,
    this.textStyle,
    this.backgroundColor,
  });

  final String title;
  final bool isShowBackButton;
  final VoidCallback? onLeadingPress;
  final List<Widget>? actions;
  final int titleMaxLine;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Palette.transparent,
      elevation: 0,
      surfaceTintColor: Palette.transparent,
      centerTitle: true,
      toolbarHeight: Spacings.xxxxLarge,
      leadingWidth: Spacings.xxxLarge,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onLeadingPress,
        icon: Padding(
          padding: const EdgeInsets.only(
            left: Spacings.large / 2,
          ),
          child: isShowBackButton ? const Icon(Icons.arrow_back) : Container(),
        ),
      ),
      title: TextLabel(
        text: title,
        maxLines: titleMaxLine,
        textAlign: TextAlign.center,
        textStyle: textStyle ??
            TextStyles.title(
              size: FontConstants.fontSizeAppBarTitle,
              fontWeight: FontConstants.medium,
            ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
