import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components/app_scaffold.dart';
import 'package:yash_practical/core/constants/spacings.dart';
import 'package:yash_practical/core/navigation/app_navigator.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      AppNavigator().navigateToDashboard(isReplace: true);
    });
    return const AppScaffold(
      showConnectivityWidget: false,
      body: Center(
        child: Icon(Icons.logo_dev, size: Spacings.xxxxLarge),
      ),
    );
  }
}
