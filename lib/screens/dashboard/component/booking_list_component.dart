import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../booking/booking_repository.dart';
import '../../booking/component/booking_item_component.dart';
import '../../booking/model/booking_list_response.dart';
import '../../booking/shimmer/booking_list_shimmer.dart';

late Function(String) onBookingListUpdate;

class BookingListComponent extends StatefulWidget {
  @override
  State<BookingListComponent> createState() => _BookingListComponentState();
}

class _BookingListComponentState extends State<BookingListComponent> {
  Future<List<BookingListData>>? future;

  List<BookingListData> bookings = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    init();

    onBookingListUpdate = (search) {
      init(flag: true, search: search);
    };
  }

  void init({bool flag = false, String search = ''}) {
    future = getBookingList(
      branchId: appStore.branchId,
      status: bookingRequestStore.selectedBookingStatusList.join(","),
      page: page,
      search: search,
      bookings: bookings,
      lastPageCallBack: (p) {
        isLastPage = p;
      },
    );
    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SnapHelperWidget<List<BookingListData>>(
          future: future,
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
          loadingWidget: BookingListShimmer(),
          onSuccess: (bookingList) {
            return AnimatedListView(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: bookingList.length,
              padding: EdgeInsets.only(left: 8, right: 8, top: 40, bottom: 12),
              shrinkWrap: true,
              emptyWidget: NoDataWidget(
                title: locale.noBookingsFound,
                subTitle: locale.thereAreNoBookings,
                retryText: locale.reload,
                onRetry: () {
                  init(flag: true);
                },
                imageWidget: EmptyStateWidget(),
              ).paddingSymmetric(horizontal: 16),
              itemBuilder: (_, i) => BookingItemComponent(bookingData: bookingList[i]),
              onNextPage: () {
                if (!isLastPage) {
                  page++;
                  appStore.setLoading(true);

                  init(flag: true);
                }
              },
              onSwipeRefresh: () async {
                page = 1;

                init(flag: true);

                return await 2.seconds.delay;
              },
            );
          },
        ),
      ],
    );
  }
}
