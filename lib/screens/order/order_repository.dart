import 'dart:convert';

import 'package:ifloriana/screens/order/model/order_list_response.dart';
import 'package:ifloriana/screens/order/model/order_status_response.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../models/base_response_model.dart';
import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import '../../utils/constants.dart';
import '../../utils/model_keys.dart';
import 'model/order_detail_response.dart';

Future<List<OrderStatusData>> getOrderStatus() async {
  try {
    var res = OrderStatusResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getOrderStatusList, method: HttpMethodType.GET)));
    appStore.setLoading(false);

    orderStatusListCached = res.data;

    return res.data.validate();
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<dynamic> updateOrderReview({
  List<XFile>? files,
  String reviewId = '',
  String productId = '',
  String productVariationId = '',
  String rating = '',
  String reviewMsg = '',
  Function(dynamic)? onSuccess,
}) async {
  if (appStore.isLoggedIn) {
    MultipartRequest multiPartRequest = await getMultiPartRequest('${reviewId.isNotEmpty ? APIEndPoints.updateReview : APIEndPoints.addReview}');

    if (reviewId.isNotEmpty) multiPartRequest.fields[ProductModelKey.reviewId] = reviewId;
    if (productId.isNotEmpty) multiPartRequest.fields[ProductModelKey.productId] = productId;
    if (productVariationId.isNotEmpty) multiPartRequest.fields[ProductModelKey.productVariationId] = productVariationId;
    if (rating.isNotEmpty) multiPartRequest.fields["rating"] = rating;
    if (reviewMsg.isNotEmpty) multiPartRequest.fields["review_msg"] = reviewMsg;

    if (files.validate().isNotEmpty) {
      multiPartRequest.files.addAll(await getMultipartImages2(files: files.validate(), name: 'gallery'));
      // multiPartRequest.fields['attachment_count'] = files.validate().length.toString();
    }

    log("Multipart ${jsonEncode(multiPartRequest.fields)}");
    log("Multipart Images ${multiPartRequest.files.map((e) => e.filename)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        onSuccess?.call(data);
      },
      onError: (error) {
        throw error;
      },
    ).catchError((error) {
      throw error;
    });
  }
}

Future<BaseResponseModel> deleteOrderReview({required int id}) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeReview}?review_id=$id', method: HttpMethodType.GET)));
}

Future placeOrderAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(APIEndPoints.placeOrder, request: request, method: HttpMethodType.POST));
}

Future orderUpdate({required int orderId}) async {
  return await handleResponse(await buildHttpResponse('${APIEndPoints.cancelOrder}?id=$orderId', method: HttpMethodType.GET));
}

Future<OrderDetailResponse> getOrderDetail({required int orderId}) async {
  try {
    var res = OrderDetailResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getOrderDetails}?order_id=$orderId', method: HttpMethodType.GET)));
    appStore.setLoading(false);

    if (orderDetailCached.any((element) => element.id == res.data!.id)) {
      orderDetailCached.removeWhere((element) => element.id == res.data!.id);
    }
    orderDetailCached.add(res.data!);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<OrderListData>> getOrderList({
  String status = '',
  String search = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<OrderListData> orders,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String statusData = status.isNotEmpty ? 'delivery_status=$status&' : '';

    String searchBooking = search.isNotEmpty ? '&search=$search&' : '';

    String perPages = 'per_page=$perPage&';
    String pages = 'page=$page';

    OrderListResponse res = OrderListResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.getOrderList}?$statusData$searchBooking$perPages$pages',
      method: HttpMethodType.GET,
    )));

    if (page == 1) orders.clear();
    orders.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);

    return orders;
  } catch (e) {
    appStore.setLoading(false);

    throw e;
  }
}