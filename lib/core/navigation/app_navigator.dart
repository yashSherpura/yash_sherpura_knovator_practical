import 'package:flutter/material.dart';
import 'package:yash_practical/core/navigation/argument.dart';
import 'package:yash_practical/core/navigation/route_navigator.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigatePageNamed({
    required String className,
    required BuildContext context,
    Argument? args,
    bool isReplace = false,
    Function()? onClose,
  }) async {
    if (isReplace) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        className,
        (Route<dynamic> route) => false,
        arguments: args,
      ).then((Object? value) {
        if (onClose != null) {
          onClose();
        }
      });
    } else {
      final dynamic result = await Navigator.pushNamed(
        context,
        className,
        arguments: args,
      );
      return result;
    }
  }

  Future<dynamic> popUp({
    BuildContext? context,
    dynamic value,
  }) async {
    Navigator.pop(context ?? navigatorKey.currentState!.context, value);
  }

  bool canPop({BuildContext? context}) {
    return Navigator.canPop(context ?? navigatorKey.currentState!.context);
  }

  Future<dynamic> popUntil({
    required BuildContext context,
    required String route,
  }) async {
    Navigator.popUntil(context, ModalRoute.withName(route));
  }

  Future<dynamic> navigateToDashboard({
    bool isReplace = false,
  }) {
    return navigatePageNamed(
      context: navigatorKey.currentState!.context,
      className: RouteGenerator.dashboardScreen,
      isReplace: isReplace,
    );
  }

  Future<dynamic> navigateToPostDetail({
    bool isReplace = false,
    required int postId,
  }) {
    return navigatePageNamed(
      context: navigatorKey.currentState!.context,
      className: RouteGenerator.postDetailScreen,
      isReplace: isReplace,
      args: ArgumentPostDetailScreen(postId: postId),
    );
  }
}
