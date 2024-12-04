import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yash_practical/core/constants/string_constants.dart';
import 'package:yash_practical/core/local_storage/local_storage_service.dart';
import 'package:yash_practical/core/navigation/app_navigator.dart';
import 'package:yash_practical/core/navigation/route_navigator.dart';
import 'package:yash_practical/core/utility/utility.dart';

const String apiBaseUrl = 'https://jsonplaceholder.typicode.com';
const String networkPingUrl = 'http://dev-gujarati-club.iconflux.info/api/ping';

Future<void> main() async {
  await initApp();
}

Future<void> initApp() async {
  runZonedGuarded<Future<dynamic>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final storageService = LocalStorageService();
    await storageService.init();
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) async {
    Utility.showLog('main error:$error');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    return MaterialApp(
      title: StringConstants.appName,
      navigatorKey: AppNavigator.navigatorKey,
      initialRoute: RouteGenerator.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
