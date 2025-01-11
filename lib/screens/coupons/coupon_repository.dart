import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/screens/coupons/model/coupon_details_model.dart';
import 'package:ifloriana/screens/coupons/model/coupon_list_model.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<CouponListModel> getCouponListData() async {
  return CouponListModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getPromotionList, method: HttpMethodType.GET)));
}
Future<CouponDetailsModel> getCouponData({required String couponCode}) async {
  return CouponDetailsModel.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getPromotionDetails}?coupon_code=$couponCode", method: HttpMethodType.GET)));
}
