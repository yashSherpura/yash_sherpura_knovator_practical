import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:yash_practical/commons/widgets/components/app_scaffold.dart';
import 'package:yash_practical/core/constants/string_constants.dart';
import 'package:yash_practical/core/themes/palette.dart';

class ConnectivityContainerWidget extends StatelessWidget {
  const ConnectivityContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(connectivity: Connectivity());
  }
}

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({required this.connectivity, super.key});

  final Connectivity connectivity;

  @override
  ConnectivityWidgetState createState() => ConnectivityWidgetState();
}

@visibleForTesting
class ConnectivityWidgetState extends State<ConnectivityWidget> {
  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Future<void> checkConnectivity() async {
    final ConnectivityResult result =
        await widget.connectivity.checkConnectivity();
    _updateSnackBarState(result);
    _subscription ??= widget.connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) {
      _updateSnackBarState(result);
    });
  }

  void _updateSnackBarState(ConnectivityResult result) {
    final bool isOffline = result == ConnectivityResult.none;
    if (isOffline) {
      AppScaffold.of(context)!.setConnectivityStatus();
      AppScaffold.of(context)!.showDefaultSnackBar(
        context: context,
        message: StringConstants.msgOffline,
        permanent: true,
        bgColor: Palette.error,
      );
    } else {
      AppScaffold.of(context)!.setConnectivityStatus(isConnection: false);
      AppScaffold.of(context)!.removeDefaultSnackBar(context: context);
    }
  }
}
