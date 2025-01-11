import 'dart:convert';

import 'package:ifloriana/screens/coupons/model/coupon_list_model.dart';

CouponDetailsModel couponDetailsModelFromJson(String str) => CouponDetailsModel.fromJson(json.decode(str));

String couponDetailsModelToJson(CouponDetailsModel data) => json.encode(data.toJson());

class CouponDetailsModel {
  bool? status;
  CouponListData? couponListData;
  String? message;

  CouponDetailsModel({
    this.status,
    this.couponListData,
    this.message,
  });

  factory CouponDetailsModel.fromJson(Map<String, dynamic> json) => CouponDetailsModel(
    status: json["status"],
    couponListData: json["data"] == null ? null : CouponListData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": couponListData?.toJson(),
    "message": message,
  };
}


