import 'package:ifloriana/screens/product/model/product_list_response.dart';

class WishListResponse {
  String? message;
  bool? status;
  ProductData? wishlist;

  WishListResponse({this.message, this.status, this.wishlist});

  factory WishListResponse.fromJson(Map<String, dynamic> json) {
    return WishListResponse(
      message: json['message'],
      status: json['status'],
      wishlist: json['wishlist'] != null ? ProductData.fromJson(json['wishlist']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.toJson();
    }
    return data;
  }
}
