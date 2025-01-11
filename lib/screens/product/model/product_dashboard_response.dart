import 'package:ifloriana/screens/product/model/product_list_response.dart';

import '../../category/model/category_response.dart';

class ProductDashboardResponse {
  bool? status;
  ProductDashboardData? data;
  String? message;

  ProductDashboardResponse({this.status, this.data, this.message});

  factory ProductDashboardResponse.fromJson(Map<String, dynamic> json) {
    return ProductDashboardResponse(
      status: json['status'],
      data: json['data'] != null ? ProductDashboardData.fromJson(json['data']) : null,
      message: json['message'],
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

class ProductDashboardData {
  List<ProductData>? bestsellerProduct;
  List<CategoryData>? category;
  List<ProductData>? discountProduct;
  List<ProductData>? featuredProduct;

  ProductDashboardData({this.bestsellerProduct, this.category, this.discountProduct, this.featuredProduct});

  factory ProductDashboardData.fromJson(Map<String, dynamic> json) {
    return ProductDashboardData(
      bestsellerProduct: json['bestseller_product'] != null ? (json['bestseller_product'] as List).map((i) => ProductData.fromJson(i)).toList() : null,
      category: json['category'] != null ? (json['category'] as List).map((i) => CategoryData.fromJson(i)).toList() : null,
      discountProduct: json['discount_product'] != null ? (json['discount_product'] as List).map((i) => ProductData.fromJson(i)).toList() : null,
      featuredProduct: json['featured_product'] != null ? (json['featured_product'] as List).map((i) => ProductData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bestsellerProduct != null) {
      data['bestseller_product'] = this.bestsellerProduct!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.discountProduct != null) {
      data['discount_product'] = this.discountProduct!.map((v) => v.toJson()).toList();
    }
    if (this.featuredProduct != null) {
      data['featured_product'] = this.featuredProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
