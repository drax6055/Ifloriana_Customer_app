import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/booking/view/booking_screen.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../components/price_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../dashboard/component/booking_list_component.dart';
import '../booking_repository.dart';
import '../model/booking_list_response.dart';
import '../view/booking_detail_screen.dart';

class BookingItemComponent extends StatelessWidget {
  final BookingListData bookingData;

  BookingItemComponent({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      margin: EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: bookingData.status == BookingStatusConst.COMPLETED ? primaryColor : territoryButtonColor,
                  borderRadius: radiusOnly(topLeft: defaultRadius),
                ),
                child: Text(
                  '#${bookingData.id.validate()}',
                  style: boldTextStyle(color: bookingData.status == BookingStatusConst.COMPLETED ? Colors.white : secondaryColor, size: 12),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: bookingData.status == BookingStatusConst.COMPLETED ? secondaryColor : territoryButtonColor,
                  borderRadius: radiusOnly(topRight: defaultRadius),
                ),
                child: PriceWidget(
                  price: bookingData.totalAmount.validate(),
                  color: bookingData.status == BookingStatusConst.COMPLETED ? Colors.white : secondaryColor,
                  size: 14,
                ),
              ),
            ],
          ),
          12.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImageWidget(
                    url: bookingData.serviceList.validate().isNotEmpty ? bookingData.serviceList!.first.serviceImage.validate() : '',
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    radius: defaultRadius,
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        directionMarguee: DirectionMarguee.oneDirection,
                        child: Text(bookingData.branchName.validate(), style: boldTextStyle()),
                      ),
                      2.height,
                      if (bookingData.serviceList.validate().isNotEmpty && bookingData.packages != null && bookingData.packages!.isEmpty)
                        Marquee(
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(
                            bookingData.serviceList.validate().map((e) => e.serviceName.validate()).toList().join(', '),
                            style: secondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ).paddingBottom(10),
                      if (bookingData.packages != null&&bookingData.packages!.isNotEmpty)
                        Marquee(
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(
                            bookingData.packages.validate().map((e) => e.packageName.validate()).toList().join(', '),
                            style: secondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ).paddingBottom(10),
                      Row(
                        children: [
                          CachedImageWidget(
                            url: bookingData.employeeImage!,
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                            circle: true,
                            child: DefaultUserImagePlaceholder(size: 12),
                          ).paddingRight(4),
                          if (bookingData.employeeName.validate().isNotEmpty)
                            Marquee(
                              child: Text(
                                bookingData.employeeName.validate(),
                                style: secondaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ).flexible(),
                        ],
                      ),
                      8.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ic_booking_status.iconImage(size: 16, color: primaryColor).paddingRight(8),
                          Text(
                            getBookingStatusKey(status: bookingData.status.validate()),
                            style: boldTextStyle(size: 13, color: getBookingStatusColor(status: bookingData.status.validate())),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ).expand(),
                ],
              ).paddingSymmetric(horizontal: 16),
              Column(
                children: [
                  Divider(color: context.dividerColor),
                  6.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ic_selected_booking.iconImage(size: 12, color: primaryColor),
                          8.width,
                          Text(bookingData.bookingDate.validate(), style: primaryTextStyle(), maxLines: 1),
                        ],
                      ),
                      Row(
                        children: [
                          ic_clock.iconImage(size: 14, color: primaryColor),
                          8.width,
                          Text(bookingData.bookingTime.validate(), style: primaryTextStyle(), maxLines: 1),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 8),
              if (bookingData.status == BookingStatusConst.COMPLETED && bookingData.packages == null)
                Column(
                  children: [
                    8.height,
                    AppButton(
                      text: locale.reschedule,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: context.width(),
                      textColor: secondaryColor,
                      color: territoryButtonColor,
                      elevation: 0,
                      onTap: () {
                        BookingScreen(services: bookingData.serviceList.validate(), isReschedule: true).launch(context);
                      },
                    ).paddingSymmetric(horizontal: 16),
                    8.height,
                  ],
                ),
              if (bookingData.status == BookingStatusConst.PENDING && (bookingData.payment == null || (bookingData.payment != null && bookingData.payment!.paymentStatus != 1)))
                AppButton(
                  text: locale.cancelAppointment,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: context.width(),
                  textColor: secondaryColor,
                  color: quaternaryButtonColor,
                  elevation: 0,
                  onTap: () {
                    showConfirmDialogCustom(
                      context,
                      title: locale.doYouWantToCancelBooking,
                      primaryColor: context.primaryColor,
                      positiveText: locale.yes,
                      negativeText: locale.no,
                      onAccept: (_) {
                        Map req = {
                          'id': bookingData.id,
                          'status': BookingStatusConst.CANCELLED,
                        };

                        appStore.setLoading(true);

                        bookingUpdate(req).then((value) {
                          onBookingListUpdate.call('');
                          appStore.setLoading(false);
                          toast(locale.bookingSuccessfullyUpdateMessage);
                        }).catchError((e) {
                          appStore.setLoading(false);
                          toast(e.toString());
                        });
                      },
                    );
                  },
                ).paddingSymmetric(horizontal: 16, vertical: 8)
              else
                Offstage(),
              8.height,
            ],
          ),
        ],
      ).onTap(() {
        hideKeyboard(context);
        BookingDetailScreen(bookingId: bookingData.id.validate(), bookingStatus: bookingData.status.validate()).launch(context);
      }, borderRadius: radius()),
    );
  }
}
