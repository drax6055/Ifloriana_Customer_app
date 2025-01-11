import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/components/logout_confirmation_dialog.dart';
import 'package:ifloriana/generated/assets.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/screens/coupons/view/coupon_list_screen.dart';
import 'package:ifloriana/screens/dashboard/component/common_app_component.dart';
import 'package:ifloriana/screens/dashboard/view/dashboard_screen.dart';
import 'package:ifloriana/screens/package/view/package_screen.dart';
import 'package:ifloriana/screens/profile/view/about_detail_screen.dart';
import 'package:ifloriana/screens/profile/view/setting_screen.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../models/about_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../auth/view/edit_profile_screen.dart';
import '../../cart/view/select_address_screen.dart';
import '../../order/view/order_list_screen.dart';
import '../../profile/view/data_provider.dart';

class ProfileFragment extends StatefulWidget {
  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  List<AboutModel> aboutAppList = [];
  List<AboutModel> helpList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() {
      aboutAppList = getAboutDataModel(context: context);
      helpList = getHelpList(context: context);
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppComponent(
            innerWidget: Text(
              locale.profile,
              style: boldTextStyle(color: white, size: APPBAR_TEXT_SIZE),
              textAlign: TextAlign.center,
            ).paddingOnly(top: 50),
            mainWidgetHeight: appStore.isLoggedIn ? 140 : 100,
            profileCircleWidget: appStore.isLoggedIn
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 100),
                          width: 100,
                          height: 100,
                          decoration: boxDecorationWithRoundedCorners(
                            boxShape: BoxShape.circle,
                            border: Border.all(color: white, width: 1),
                          ),
                          child: Observer(builder: (context) {
                            return CachedImageWidget(
                              url: userStore.userProfileImage.validate(),
                              height: 120,
                              fit: BoxFit.cover,
                              width: 120,
                              radius: 150,
                              child: DefaultUserImagePlaceholder(),
                            );
                          }),
                        ),
                        Positioned(
                          bottom: 12,
                          right: -8,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6),
                            decoration: boxDecorationDefault(
                              shape: BoxShape.circle,
                              color: primaryColor,
                              border: Border.all(color: context.cardColor, width: 2),
                            ),
                            child: Icon(Icons.edit, color: white, size: 18),
                          ).onTap(
                            () {
                              EditProfileScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(height: 120, width: 100),
            subWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appStore.isLoggedIn)
                  Column(
                    children: [
                      24.height,
                      Observer(builder: (context) {
                        String firstName = userStore.userFirstName.trim();
                        String lastName = userStore.userLastName.trim() ;
                        String displayName = lastName.isNotEmpty && lastName != "Unknown" ? '$firstName $lastName' : firstName;
                        return Text(displayName, style: boldTextStyle(size: 18)).center();
                      }),
                      4.height,
                      Observer(builder: (context) {
                        return Text(userStore.userEmail.validate(), style: secondaryTextStyle()).center();
                      }),
                      16.height,
                    ],
                  ),
                Column(
                  children: [
                    SettingItemWidget(
                      title: locale.orders,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.seeYourOrders,
                      leading: ic_order.iconImage(fit: BoxFit.cover, size: 16),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        OrderListScreen(showBack: true).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).visible(appStore.isLoggedIn),
                    if (appStore.isLoggedIn) 16.height,
                    SettingItemWidget(
                      title: locale.myPackages,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.availablePackages,
                      leading: Assets.iconsIcSealPercent.iconImage(fit: BoxFit.cover, size: 18),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        PackagesScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).paddingBottom(16).visible(appStore.isLoggedIn),
                    SettingItemWidget(
                      title: locale.coupons,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.myDiscountCoupons,
                      leading: ic_gift.iconImage(fit: BoxFit.cover, size: 16),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        CouponListScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).visible(appStore.isLoggedIn),
                    if (appStore.isLoggedIn) 16.height,
                    SettingItemWidget(
                      title: locale.myAddresses,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.manageYourAddresses,
                      leading: ic_location.iconImage(fit: BoxFit.cover, size: 16),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        SelectAddressScreen(isFromProfile: true).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).visible(appStore.isLoggedIn),
                    if (appStore.isLoggedIn) 16.height,
                    SettingItemWidget(
                      title: locale.setting,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: !isSocialLoginType ? '${locale.changePassword}, ${locale.appLanguage}, ${locale.theme}, ${locale.deleteAccount}' : '${locale.appLanguage}, ${locale.theme}, ${locale.deleteAccount}',
                      leading: ic_setting.iconImage(fit: BoxFit.cover, size: 16),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        SettingScreen().launch(context);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    16.height,
                    SettingItemWidget(
                      title: locale.aboutApp,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: '${locale.rateUs}, ${locale.share}, ${locale.about}',
                      leading: ic_about.iconImage(fit: BoxFit.cover, size: 18),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        AboutDetailScreen(aboutModel: aboutAppList, title: locale.aboutApp).launch(context);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    16.height,
                    SettingItemWidget(
                      title: locale.help,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: '${locale.helpCenter}, ${locale.privacyPolicy}, ${locale.tC}',
                      leading: ic_help.iconImage(fit: BoxFit.cover, size: 16),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        AboutDetailScreen(aboutModel: helpList, title: locale.help).launch(context);
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    16.height,
                    SettingItemWidget(
                      title: locale.signIn,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.signInYourAccount,
                      leading: ic_logout.iconImage(fit: BoxFit.cover, size: 14),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () {
                        doIfLoggedIn(context, () {
                          DashboardScreen(pageIndex: 4).launch(context, isNewTask: true);
                        });
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).visible(!appStore.isLoggedIn),
                    SettingItemWidget(
                      title: locale.logout,
                      titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                      subTitle: locale.logoutYourAccount,
                      leading: ic_logout.iconImage(fit: BoxFit.cover, size: 14),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      onTap: () async {
                        bool? res = await showInDialog(
                          context,
                          contentPadding: EdgeInsets.zero,
                          transitionDuration: 100.milliseconds,
                          builder: (p0) {
                            return LogoutConfirmationDialog();
                          },
                        );

                        if (res ?? false) {
                          await 50.milliseconds.delay;

                          appStore.setLoading(true);
                          String branchAddress = appStore.branchAddress;
                          String branchName = appStore.branchName;
                          int branchId = appStore.branchId;
                          String branchContactNumber = appStore.branchContactNumber;

                          await logoutApi().then((value) async {
                            //
                          }).catchError((e) {
                            log(e.toString());
                          });

                          appStore.setLoading(false);

                          await appStore.setBranchAddress(branchAddress);
                          await appStore.setBranchId(branchId);
                          await appStore.setBranchName(branchName);
                          await appStore.setBranchContactNumber(branchContactNumber);
                          productStore.setCartItemCount(0);

                          DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                        }
                      },
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ).visible(appStore.isLoggedIn),
                    30.height,
                    SnapHelperWidget<PackageInfoData>(
                      future: getPackageInfo(),
                      onSuccess: (data) {
                        return VersionInfoWidget(prefixText: 'v', textStyle: primaryTextStyle()).center();
                      },
                    ),
                  ],
                ).paddingSymmetric(vertical: 16, horizontal: 16),
              ],
            ),
          ),
         //Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
