import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants.dart';
import 'body_widget.dart';

class AppScaffold extends StatelessWidget {
  final String? appBarTitle;
  final List<Widget>? actions;
  final bool showAppBar;
  final PreferredSizeWidget? appBarWidget;
  final Widget body;
  final Widget? floatingActionButton;
  final Color? scaffoldBackgroundColor;

  AppScaffold({
    this.appBarTitle,
    required this.body,
    this.actions,
    this.scaffoldBackgroundColor,
    this.showAppBar = true,
    this.floatingActionButton,
    this.appBarWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? appBarWidget ??
              AppBar(
                centerTitle: true,
                title: Text(
                  appBarTitle.validate(),
                  style: boldTextStyle(color: Colors.white, size: APPBAR_TEXT_SIZE),
                ),
                elevation: 0.0,
                backgroundColor: context.primaryColor,
                actions: actions,
              )
          : null,
      backgroundColor: scaffoldBackgroundColor,
      floatingActionButton: floatingActionButton,
      body: Body(child: body),
    );
  }
}
