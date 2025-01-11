import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/screens/auth/view/sign_in_screen.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/voice_search_component.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../branch/view/select_branch_screen.dart';
import '../../order/view/order_list_screen.dart';
import '../../product/view/product_dashboard_screen.dart';
import '../fragment/booking_fragment.dart';
import '../fragment/home_fragment.dart';
import '../fragment/profile_fragment.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  const DashboardScreen({super.key, this.pageIndex = 0});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  int currentPosition = 0;

  List<Widget> fragmentList = [
    HomeFragment(),
    Observer(builder: (context) => appStore.isLoggedIn ? BookingFragment() : SignInScreen(isFromDashboard: true)),
    ProductScreen(),
    Observer(builder: (context) => appStore.isLoggedIn ? OrderListScreen(showBack: false) : SignInScreen(isFromDashboard: true)),
    ProfileFragment(),
  ];


  @override
  void initState() {
    currentPosition = widget.pageIndex;
    if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
      WidgetsBinding.instance.addObserver(this);
    }
    super.initState();
    init();

    LiveStream().on("Hello", (value) {
      if (value == 1) {
        SignInScreen().launch(context,isNewTask: true);
        // setState(() {});
      }
    });
  }

  void init() async {
    afterBuildCreated(() async {
      /// Changes System theme when changed
      if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
        appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
      }

      /*View.of(context).platformDispatcher.onPlatformBrightnessChanged = () async {
        if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
          appStore.setDarkMode(MediaQuery.of(context).platformBrightness == Brightness.light);
        }
      };*/

      //WidgetsBinding.instance.handlePlatformBrightnessChanged();
    });

    /// ForceUpdate Dialog
    await 3.seconds.delay;
    showForceUpdateDialog(context);

    if (!appStore.isBranchSelected) {
      SelectBranchScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangePlatformBrightness() {
    if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
      appStore.setDarkMode(MediaQuery.of(context).platformBrightness == Brightness.light);
    }
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: locale.pressBackAgainToExitApp,
      child: Scaffold(
        body: fragmentList[currentPosition],
        bottomNavigationBar: Blur(
          blur: 30,
          borderRadius: radius(0),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: context.primaryColor.withOpacity(0.02),
              indicatorColor: context.primaryColor.withOpacity(0.1),
              labelTextStyle: WidgetStateProperty.all(primaryTextStyle(size: 12)),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: currentPosition,
              onDestinationSelected: (index) {
                currentPosition = index;
                setState(() {});
              },
              destinations: [
                bottomTab(
                  iconData: ic_unselected_home.iconImage(color: appTextSecondaryColor, size: 18),
                  activeIconData: ic_selected_home.iconImage(color: context.primaryColor, size: 18),
                  tabName: locale.home,
                ),
                bottomTab(
                  iconData: ic_unselected_booking.iconImage(color: appTextSecondaryColor, size: 18),
                  activeIconData: ic_selected_booking.iconImage(color: context.primaryColor, size: 18),
                  tabName: locale.booking,
                ),
                bottomTab(
                  iconData: ic_unselected_shop.iconImage(color: appTextSecondaryColor, size: 20),
                  activeIconData: ic_selected_shop.iconImage(color: context.primaryColor, size: 20),
                  tabName: locale.shop,
                ),
                bottomTab(
                  iconData: ic_order.iconImage(color: appTextSecondaryColor, size: 20),
                  activeIconData: ic_selected_order.iconImage(color: context.primaryColor, size: 20),
                  tabName: locale.orders,
                ),
                Observer(builder: (context) {
                  return bottomTab(
                    iconData: appStore.isLoggedIn
                        ? CachedImageWidget(
                            url: userStore.userProfileImage.validate(),
                            height: 26,
                            fit: BoxFit.cover,
                            width: 26,
                            radius: 30,
                            child: ic_unselected_profile.iconImage(color: appTextSecondaryColor, size: 18),
                          )
                        : ic_unselected_profile.iconImage(color: appTextSecondaryColor, size: 18),
                    activeIconData: appStore.isLoggedIn
                        ? CachedImageWidget(
                            url: userStore.userProfileImage.validate(),
                            height: 26,
                            fit: BoxFit.cover,
                            width: 26,
                            radius: 30,
                            child: ic_selected_profile.iconImage(color: context.primaryColor, size: 18),
                          )
                        : ic_selected_profile.iconImage(color: context.primaryColor, size: 18),
                    tabName: locale.profile,
                  );
                }),
              ],
            ),
          ),
        ),
        bottomSheet: Observer(builder: (context) {
          return VoiceSearchComponent().visible(appStore.isSpeechActivated);
        }),
      ),
    );
  }
}
