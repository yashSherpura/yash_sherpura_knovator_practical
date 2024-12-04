import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yash_practical/core/services/connectivity_config/connectivity_widget.dart';
import 'package:yash_practical/core/themes/themes.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.systemUiOverlayStyleIOS,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.gradient,
    this.drawer,
    this.scaffoldKey,
    this.showBanner = true,
    this.showHeader = false,
    this.headerHeight,
    this.showConnectivityWidget = true,
    this.drawerEdgeDragWidth,
  });

  final GlobalKey? scaffoldKey;

  final Widget body;

  final PreferredSizeWidget? appBar;

  final SystemUiOverlayStyle? systemUiOverlayStyleIOS;

  final Color? backgroundColor;

  final Widget? bottomNavigationBar;

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  final Gradient? gradient;
  final Widget? drawer;
  final bool showBanner;
  final bool showHeader;
  final double? headerHeight;
  final bool showConnectivityWidget;
  final double? drawerEdgeDragWidth;

  @override
  AppScaffoldState createState() => AppScaffoldState();

  static AppScaffoldState? of(BuildContext context, {bool nullOk = false}) {
    final AppScaffoldState? result =
        context.findAncestorStateOfType<AppScaffoldState>();
    if (nullOk || result != null) {
      return result;
    }
    throw 'AppScaffold.of() called with a'
        ' context that does not contain a AppScaffold.';
  }
}

class AppScaffoldState extends State<AppScaffold> {
  bool isOffline = false;

  void setConnectivityStatus({bool isConnection = true}) {
    isOffline = isConnection;
    setState(() {});
  }

  void showDefaultSnackBar({
    @required BuildContext? context,
    @required String? message,
    bool? permanent = false,
    Color? bgColor,
  }) {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message!,
          textAlign: TextAlign.center,
          style: TextStyles.titleMedium(
            color: Palette.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor ?? Palette.error,
        duration: getDuration(permanent: permanent),
      ),
    );
  }

  Duration getDuration({bool? permanent = false}) {
    if (permanent!) {
      return const Duration(days: 365);
    } else {
      return const Duration(milliseconds: 4000);
    }
  }

  void removeDefaultSnackBar({@required BuildContext? context}) {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: widget.scaffoldKey,
          drawer: widget.drawer,
          backgroundColor: widget.backgroundColor,
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          appBar: widget.appBar,
          drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
          body: widget.showHeader
              ? Stack(
                  children: <Widget>[
                    Container(
                      height: widget.headerHeight,
                      width: MediaQuery.of(context).size.width,
                      color: Palette.primary,
                    ),
                    widget.body,
                    if (widget.showConnectivityWidget)
                      const ConnectivityContainerWidget(),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    widget.body,
                    if (widget.showConnectivityWidget)
                      const ConnectivityContainerWidget(),
                  ],
                ),
        ),
      ],
    );
  }
}
