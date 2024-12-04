import 'package:flutter/material.dart';
import 'package:yash_practical/presentation/dashboard/dashboard_screen.dart';
import 'package:yash_practical/presentation/post_detail/post_detail_screen.dart';
import 'package:yash_practical/presentation/splash/splash_screen.dart';

class RouteGenerator {
  static const String splashScreen = '/';
  static const String dashboardScreen = '/dashboard';
  static const String postDetailScreen = '/postDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routingData = settings.name;
    switch (routingData) {
      case splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return const SplashScreen();
          },
          settings: settings,
        );

      case dashboardScreen:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return const DashboardScreen();
          },
          settings: settings,
        );

      case postDetailScreen:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return const PostDetailScreen();
          },
          settings: settings,
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return const SplashScreen();
          },
          settings: settings,
        );
    }
  }
}
