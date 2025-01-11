import 'package:ifloriana/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class AppLanguageScreen extends StatefulWidget {
  @override
  _AppLanguageScreenState createState() => _AppLanguageScreenState();
}

class _AppLanguageScreenState extends State<AppLanguageScreen> {

 @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
  //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.appLanguage, appBarHeight: 70, roundCornerShape: true, showLeadingIcon: true),
      body: LanguageListWidget(
        widgetType: WidgetType.LIST,
        onLanguageChange: (v) {
          appStore.setLanguage(v.languageCode!);
          setState(() {});
          finish(context, true);
        },
      ),
    );
  }
}