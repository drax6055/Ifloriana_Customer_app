import 'package:ifloriana/screens/product/model/product_list_response.dart';

class ProductDetailResponse {
  ProductData? data;
  String? message;
  bool? status;
  List<ProductData>? relatedProduct;

  ProductDetailResponse({this.data, this.message, this.status, this.relatedProduct});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
      relatedProduct: json['related-product'] != null ? (json['related-product'] as List).map((i) => ProductData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
