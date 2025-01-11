import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:ifloriana/screens/booking/model/booking_list_response.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/constants.dart';
import '../order/model/order_status_response.dart';
import 'model/booking_status_response.dart';

Future<List<BookingStatusData>> getBookingStatus() async {
  try {
    var res = BookingStatusResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.bookingStatus, method: HttpMethodType.GET)));
    appStore.setLoading(false);

    bookingStatusListCached = res.data;

    return res.data.validate();
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<BookingDetailResponse> getBookingDetail({required int bookingId}) async {
  try {
    var res = BookingDetailResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.bookingDetail}?id=$bookingId', method: HttpMethodType.GET)));
    appStore.setLoading(false);

    if (bookingDetailCached.any((element) => element.id == res.data!.id)) {
      bookingDetailCached.removeWhere((element) => element.id == res.data!.id);
    }
    bookingDetailCached.add(res.data!);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future saveBookingAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(APIEndPoints.saveBooking, request: request, method: HttpMethodType.POST));
}

Future bookingUpdate(Map request) async {
  return await handleResponse(await buildHttpResponse(APIEndPoints.bookingUpdate, request: request, method: HttpMethodType.POST));
}

Future<BookingStatusResponse> getInvoiceLink({required String bookingId}) async {
  return BookingStatusResponse.fromJson(
      await handleResponse(
          await buildHttpResponse("${APIEndPoints.bookingInvoiceDownload}?id=$bookingId", method: HttpMethodType.GET)));
}

Future<OrderStatusResponse> getOrderInvoiceLink({required String orderId}) async {
  print("Fetching PDF for order ID: $orderId");

  return OrderStatusResponse.fromJson(
    await handleResponse(
        await buildHttpResponse("${APIEndPoints.orderInvoiceDownload}="
            "$orderId", method: HttpMethodType.GET)));

}

Future verifySlot(int employeeId, String startDateTime) async {
  Map request = {
    "employee_id": employeeId,
    "start_date_time": startDateTime, //"2023-06-15 09:30:00"
  };
  return await handleResponse(await buildHttpResponse(APIEndPoints.verifySlot, request: request, method: HttpMethodType.POST));
}

Future<List<BookingListData>> getBookingList({
  int? branchId,
  String status = '',
  String search = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<BookingListData> bookings,
  Function(bool)? lastPageCallBack,
}) async {
  String statusData = status.isNotEmpty ? '&status=$status' : '';

  String searchBooking = search.isNotEmpty ? '&search=$search' : '';

  BookingListResponse res = BookingListResponse.fromJson(await handleResponse(await buildHttpResponse(
    '${APIEndPoints.bookingList}?branch_id=$branchId$statusData$searchBooking&per_page=$perPage&page=$page',
    method: HttpMethodType.GET,
  )));

  if (page == 1) bookings.clear();
  bookings.addAll(res.data.validate());

  lastPageCallBack?.call(res.data.validate().length != perPage);

  appStore.setLoading(false);

  return bookings;
  try {
    String statusData = status.isNotEmpty ? '&status=$status' : '';

    String searchBooking = search.isNotEmpty ? '&search=$search' : '';

    BookingListResponse res = BookingListResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.bookingList}?branch_id=$branchId$statusData$searchBooking&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));

    if (page == 1) bookings.clear();
    bookings.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);

    return bookings;
  } catch (e) {
    appStore.setLoading(false);

    throw e;
  }
}
