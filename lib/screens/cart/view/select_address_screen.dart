import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/screens/cart/cart_repository.dart';
import 'package:ifloriana/screens/cart/model/address_list_response.dart';
import 'package:ifloriana/screens/cart/model/logistic_zone_response.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/dotted_line.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../order/view/additional_detail_screen.dart';
import 'add_address_screen.dart';

class SelectAddressScreen extends StatefulWidget {
  final bool isFromProfile;

  SelectAddressScreen({this.isFromProfile = false});

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  Future<List<UserAddress>>? future;

  List<UserAddress> addressList = [];
  List<LogisticZoneData> logisticList = [];

  int page = 1;

  bool isLastPage = false;
  bool isSelectedLogistic = false;

  int defaultAddressId = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    future = getAddressList(
      page: page,
      addressList: addressList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    ).whenComplete(() async {
      try {
        if (addressList.isNotEmpty) {
          defaultAddressId = addressList.firstWhere((element) => element.isPrimary.validate().getBoolInt(), orElse: () => UserAddress()).id.validate();
          await getLogisticZoneApi(addressId: defaultAddressId);
          productStore.setSelectedAddressData(addressList.firstWhere((element) => element.isPrimary.validate().getBoolInt(), orElse: () => UserAddress()));
        }
      } catch (e) {
        appStore.setLoading(false);
        log('Error defaultAddress: $e');
      }

      if (flag) setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget buildIconWidget({required String icon, required VoidCallback onTap}) {
    return SizedBox(
      height: 38,
      width: 38,
      child: IconButton(padding: EdgeInsets.zero, icon: icon.iconImage(size: 18), onPressed: onTap),
    );
  }

  Future<void> getLogisticZoneApi({required int addressId}) async {
    appStore.setLoading(true);

    await getLogisticZone(addressId: addressId).then((value) async {
      logisticList.clear();
      logisticList.addAll(value);
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(context, title: locale.selectAddress, appBarHeight: 70, showLeadingIcon: true, roundCornerShape: true),
      body: Stack(
        children: [
          SnapHelperWidget<List<UserAddress>>(
            future: future,
            loadingWidget: LoaderWidget(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init(flag: true);
                },
              );
            },
            onSuccess: (addressList) {
              if (addressList.isEmpty) {
                return NoDataWidget(
                  title: '${locale.opps}! ${locale.looksLikeYouHave}',
                  retryText: locale.reload,
                  imageWidget: EmptyStateWidget(),
                  onRetry: () async {
                    // final result = await AddAddressScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                    // if (result == true) {
                    //   page = 1;
                      appStore.setLoading(true);
                      init(flag: true);
                    // }
                  },
                ).paddingSymmetric(horizontal: 32);
              }

              return AnimatedScrollView(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 90, top: 20),
                physics: AlwaysScrollableScrollPhysics(),
                onSwipeRefresh: () async {
                  page = 1;
                  appStore.setLoading(true);
                  init(flag: true);
                  return await Future.delayed(const Duration(seconds: 2));
                },
                children: [
                  AnimatedListView(
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      UserAddress addressData = addressList[index];

                      return Container(
                        decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius()),
                        margin: EdgeInsets.only(bottom: 16),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                8.height,
                                RadioListTile(
                                  value: addressData.id.validate(),
                                  groupValue: defaultAddressId,
                                  shape: RoundedRectangleBorder(borderRadius: radius()),
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  contentPadding: EdgeInsets.all(8),
                                  title: Text(
                                    "${addressData.firstName.validate()} ${addressData.lastName.validate()}",
                                    style: boldTextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${addressData.addressLine1.validate()} ${addressData.addressLine2.validate()}',
                                        style: secondaryTextStyle(size: 12),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${addressData.cityName.validate()}' ' - ${addressData.postalCode.validate()}',
                                        style: secondaryTextStyle(size: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${addressData.stateName.validate()}' ', ${addressData.countryName.validate()}',
                                        style: secondaryTextStyle(size: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  secondary: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildIconWidget(
                                        icon: ic_edit_square,
                                        onTap: () async {
                                          final result = await AddAddressScreen(address: addressData).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                                          if (result == true) {
                                            page = 1;
                                            appStore.setLoading(true);
                                            init(flag: true);
                                          }
                                        },
                                      ),
                                      buildIconWidget(
                                        icon: ic_delete,
                                        onTap: () => handleDeleteAddressClick(addressList, index, context),
                                      ).visible(!addressData.isPrimary.validate().getBoolInt()),
                                    ],
                                  ),
                                  onChanged: (value) async {
                                    defaultAddressId = addressData.id.validate();

                                    if (!widget.isFromProfile) {
                                      /// LogisticZone Api
                                      await getLogisticZoneApi(addressId: defaultAddressId);
                                    }

                                    productStore.setSelectedAddressData(addressData);
                                    setState(() {});
                                  },
                                ),
                                if (!widget.isFromProfile) logisticWidget(context).visible(defaultAddressId == addressData.id.validate()),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: territoryButtonColor,
                                  borderRadius: radiusOnly(bottomLeft: defaultRadius),
                                ),
                                child: Text(locale.primary, style: boldTextStyle(color: secondaryColor, size: 12)),
                              ),
                            ).visible(addressData.isPrimary.validate().getBoolInt()),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: boxDecorationDefault(color: context.cardColor, border: Border.all(color: primaryColor)),
                  child: Text(locale.addNewAddress, style: boldTextStyle(color: primaryColor)),
                ).onTap(() async {
                  final result = await AddAddressScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                  if (result == true) {
                    page = 1;
                    appStore.setLoading(true);
                    init(flag: true);
                  }
                }, borderRadius: radius()).expand(),
                if (isSelectedLogistic) 12.width,
                if (isSelectedLogistic)
                  AppButton(
                    width: context.width(),
                    child: Text(locale.deliverHere, style: boldTextStyle(color: Colors.white)),
                    color: secondaryColor,
                    onTap: () {
                      AdditionalDetailScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ).expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleDeleteAddressClick(List<UserAddress> addressList, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: '${locale.areYouSureYouWantToDelete}?',
      positiveText: locale.delete,
      negativeText: locale.cancel,
      onAccept: (ctx) async {
        appStore.setLoading(true);
        removeAddress(addressId: addressList[index].id.validate()).then((value) {
          addressList.removeAt(index);
          if (value.message.validate().isNotEmpty) toast(locale.addressDeleteSuccessfully);
          setState(() {});
          appStore.setLoading(false);
        }).catchError(onError);
      },
    );
  }

  /// Logistic Zone Widget
  Widget logisticWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (logisticList.isEmpty) Text('*${locale.weAreNotShipping}.', style: secondaryTextStyle(color: wishListColor, fontStyle: FontStyle.italic)),
        if (logisticList.isNotEmpty) DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
        8.height,
        if (logisticList.isNotEmpty)
          Text(
            locale.deliveryCharge,
            style: secondaryTextStyle(color: Colors.green, size: 14, fontStyle: FontStyle.italic),
          ).paddingSymmetric(horizontal: 16),
        AnimatedWrap(
          itemCount: logisticList.length,
          itemBuilder: (context, index) {
            LogisticZoneData logisticData = logisticList[index];

            return Container(
              decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius()),
              padding: EdgeInsets.only(left: 10, right: 16, bottom: 10),
              child: CheckboxListTile(
                value: logisticData.isLogisticCheck,
                title: Text(
                  logisticData.name.validate(),
                  style: boldTextStyle(color: appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor, size: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                secondary: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(logisticData.standardDeliveryTime.validate(), style: secondaryTextStyle()),
                    8.width,
                    PriceWidget(price: logisticData.standardDeliveryCharge.validate()),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
                side: BorderSide(color: textSecondaryColorGlobal),
                dense: true,
                activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
                onChanged: (value) {
                  logisticData.isLogisticCheck = !logisticData.isLogisticCheck;

                  if (logisticData.isLogisticCheck) {
                    isSelectedLogistic = logisticData.isLogisticCheck;
                    productStore.setLogisticZoneData(logisticData);
                  } else {
                    isSelectedLogistic = logisticData.isLogisticCheck;
                    productStore.setLogisticZoneData(LogisticZoneData());
                  }

                  setState(() {});
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
