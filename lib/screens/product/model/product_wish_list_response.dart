import 'package:ifloriana/screens/product/model/product_list_response.dart';

class ProductWishListResponse {
  List<ProductData>? data;
  String? message;
  bool? status;

  ProductWishListResponse({this.data, this.message, this.status});

  factory ProductWishListResponse.fromJson(Map<String, dynamic> json) {
    return ProductWishListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => ProductData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
