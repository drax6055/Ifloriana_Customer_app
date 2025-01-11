import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../booking/booking_repository.dart';
import '../../booking/model/booking_status_response.dart';
import '../component/booking_list_component.dart';

class BookingFragment extends StatefulWidget {
  @override
  _BookingFragmentState createState() => _BookingFragmentState();
}

class _BookingFragmentState extends State<BookingFragment> {
  TextEditingController searchBookingCont = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  Future<List<BookingStatusData>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    //
    if (flag) setState(() {});
  }

  Future<List<BookingStatusData>>? fetchBookingStatusApi() {
    future = getBookingStatus();

    return future;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: PreferredSize(
        preferredSize: Size(context.width(), 100),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: context.width(),
              height: 150,
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                backgroundColor: context.primaryColor,
              ),
              child: appBarWidget(
                locale.booking,
                center: true,
                showBack: false,
                color: context.primaryColor,
                textColor: white,
                textSize: APPBAR_TEXT_SIZE,
              ).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
            ),
            Positioned(
              bottom: -20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  AppTextField(
                    controller: searchBookingCont,
                    textFieldType: TextFieldType.OTHER,
                    focus: searchFocusNode,
                    suffix: CloseButton(
                      onPressed: () {
                        hideKeyboard(context);
                        searchBookingCont.clear();

                        appStore.setLoading(true);
                        onBookingListUpdate.call(searchBookingCont.text);
                        setState(() {});
                      },
                    ).visible(searchBookingCont.text.isNotEmpty),
                    onFieldSubmitted: (s) {
                      appStore.setLoading(true);
                      onBookingListUpdate.call(searchBookingCont.text);
                      setState(() {});
                    },
                    decoration: inputDecoration(context, hint: locale.searchBooking, prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal)),
                  ).expand(),
                  16.width,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: boxDecorationDefault(color: secondaryColor),
                    child: CachedImageWidget(
                      url: ic_filter,
                      height: 26,
                      width: 26,
                      color: Colors.white,
                    ),
                  ).onTap(() {
                    handleFilterClick(context);
                  }, borderRadius: radius()),
                ],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          BookingListComponent(),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Container(
          width: context.width(),
          constraints: BoxConstraints(minWidth: context.height() * 0.65, maxHeight: context.height() * 0.45),
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          ),
          child: SnapHelperWidget<List<BookingStatusData>>(
            future: fetchBookingStatusApi(),
            initialData: bookingStatusListCached,
            loadingWidget: LoaderWidget(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);

                  fetchBookingStatusApi();
                  setState(() {});
                },
              );
            },
            onSuccess: (statusList) {
              if (statusList.isEmpty) {
                return NoDataWidget(
                  title: locale.noTimeSlots,
                  retryText: locale.reload,
                  onRetry: () {
                    appStore.setLoading(true);

                    fetchBookingStatusApi();
                    setState(() {});
                  },
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locale.filterBy, style: primaryTextStyle(size: 18)).paddingOnly(left: 25),
                      CloseButton(
                        onPressed: () {
                          hideKeyboard(context);
                          finish(context);
                        },
                      ).paddingOnly(right: 16),
                    ],
                  ),
                  10.height,
                  Divider(color: context.dividerColor, height: 0).paddingSymmetric(horizontal: 16),
                  22.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.bookingStatus, style: secondaryTextStyle()).paddingSymmetric(horizontal: 16),
                      16.height,
                      AnimatedWrap(
                        runSpacing: 10,
                        spacing: 10,
                        itemCount: statusList.length,
                        listAnimationType: ListAnimationType.None,
                        itemBuilder: (context, index) {
                          BookingStatusData statusData = statusList[index];

                          return Observer(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                if (bookingRequestStore.selectedBookingStatusList.contains(statusData.status)) {
                                  bookingRequestStore.selectedBookingStatusList.remove(statusData.status);
                                } else {
                                  bookingRequestStore.selectedBookingStatusList.add(statusData.status.validate());
                                }
                              },
                              child: Container(
                                width: context.width() / 3.7,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: boxDecorationDefault(
                                  color: bookingRequestStore.selectedBookingStatusList.contains(statusData.status)
                                      ? appStore.isDarkMode
                                          ? primaryColor
                                          : lightPrimaryColor
                                      : appStore.isDarkMode
                                          ? primaryColor.withOpacity(0.1)
                                          : Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    ).visible(bookingRequestStore.selectedBookingStatusList.contains(statusData.status)),
                                    4.width.visible(bookingRequestStore.selectedBookingStatusList.contains(statusData.status)),
                                    Text(
                                      getBookingStatusKey(status: statusData.status.validate()),
                                      style: secondaryTextStyle(
                                        color: bookingRequestStore.selectedBookingStatusList.contains(statusData.status) ? Colors.white : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ).paddingSymmetric(horizontal: 16).expand(),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppButton(
                            text: locale.clearFilter,
                            textStyle: boldTextStyle(color: Colors.white),
                            color: secondaryColor,
                            onTap: () {
                              bookingRequestStore.selectedBookingStatusList.clear();
                              finish(context);
                              appStore.setLoading(true);
                              onBookingListUpdate.call('');
                            },
                          ).expand(),
                          16.width,
                          AppButton(
                            text: locale.apply,
                            textStyle: boldTextStyle(color: Colors.white),
                            color: primaryColor,
                            onTap: () {
                              finish(context);
                              appStore.setLoading(true);
                              onBookingListUpdate.call('');
                            },
                          ).expand(),
                        ],
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ).expand(),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
