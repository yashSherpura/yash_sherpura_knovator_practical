import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components.dart';
import 'package:yash_practical/core/themes/themes.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    this.message = 'Loading...',
    this.isCard = true,
    this.isCurve = false,
    this.color = Colors.white,
    this.isOpacity = false,
    this.height,
    this.width,
  });

  final String message;
  final bool isCard;
  final Color color;
  final bool isOpacity;
  final bool isCurve;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return isCard
        ? Container(
            decoration: BoxDecoration(
              color: isOpacity
                  ? Colors.transparent
                  : Colors.transparent.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isCurve ? 20 : 0),
                topRight: Radius.circular(isCurve ? 20 : 0),
              ),
            ),
            height: height ?? MediaQuery.of(context).size.height,
            width: width ?? MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: width == null
                    ? MediaQuery.of(context).size.width * 0.5
                    : width! * 0.5,
                height: height == null
                    ? MediaQuery.of(context).size.height * 0.25
                    : height! * 0.25,
                decoration: const BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Material(
                  color: Palette.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Palette.primary),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextLabel(
                          text: message,
                          textAlign: TextAlign.center,
                          textStyle: TextStyles.normalMedium(
                            color: Palette.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.primary),
              ),
            ),
          );
  }
}
