import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifloriana/screens/branch/view/select_branch_screen.dart';
import 'package:ifloriana/screens/dashboard/view/dashboard_screen.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/no_branch_error_widget.dart';
import '../main.dart';
import '../network/rest_apis.dart';
import '../utils/constants.dart';
import 'branch/branch_repository.dart';
import 'walkThrough/view/walk_through_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: context.primaryColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    });

    await getBranchList(branchList: []).then((value) {
      if (value.isNotEmpty) {
        if (value.length == 1) {
          setBranchAndRedirectToDashboard(value.first);
        } else {
          bool isIdAvailable = value.any((element) =>
              element.id.toString() == appStore.branchId.toString());
          if (!isIdAvailable) {
           appStore.setBranchId(UNSELECTED_BRANCH_ID);
          } 
        }
      }
    }).catchError((e) {
      /// When error occurs in Branch List API
      push(NoBranchErrorWidget(errorMessage: e.toString()),
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    });

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX); //TODO
    if (themeModeIndex == ThemeConst.THEME_MODE_LIGHT) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == ThemeConst.THEME_MODE_DARK) {
      appStore.setDarkMode(true);
    }

    ///Set app configurations
    getAppConfigurations().then((value) {}).catchError((e) {
      log(e);
    });

    if (getBoolAsync(SharedPreferenceConst.IS_FIRST_TIME, defaultValue: true)) {
      WalkThroughScreen().launch(context, isNewTask: true);
    } else if (appStore.isBranchSelected) {
      DashboardScreen().launch(context, isNewTask: true);
    } else {
      SelectBranchScreen(isFromDashboard: true).launch(context, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.primaryColor,
        height: context.height(),
        width: context.width(),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: boxDecorationDefault(shape: BoxShape.circle),
          child: Image.asset(logo_gif, height: 150, width: 150, fit: BoxFit.cover),
        ).center(),
      ),
    );
  }
}
