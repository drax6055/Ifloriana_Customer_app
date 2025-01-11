import 'package:ifloriana/screens/product/model/product_review_data_model.dart';

import '../../category/model/category_response.dart';

class ProductListResponse {
  List<ProductData>? data;
  String? message;
  bool? status;

  ProductListResponse({this.data, this.message, this.status});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
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

class ProductData {
  int? brandId;
  String? brandName;
  List<CategoryData>? category;
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  String? description;
  String? discountEndDate;
  String? discountStartDate;
  String? discountType;
  num? discountValue;
  int? id;
  int? inWishlist;
  num? maxPrice;
  num? minPrice;
  String? name;
  String? productImage;
  int? sellTarget;
  String? shortDescription;
  String? slug;
  int? stockQty;
  int? unitId;
  String? unitName;
  String? updatedAt;
  int? updatedBy;
  num? taxIncludeMinPrice;
  num? taxIncludeMaxPrice;
  num? minDiscountedProductAmount;
  num? maxDiscountedProductAmount;
  int? isPublished;
  int? minPurchaseQty;
  int? maxPurchaseQty;
  int? hasVariation;
  int? hasWarranty;
  int? ratingCount;
  num? rating;
  List<VariationData>? variationData;
  List<String>? productGallaryData;
  List<ProductReviewDataModel>? productReview;

  ///discount product
  int? status;

  ///wishlist
  int? userId;
  int? productId;
  String? productName;
  String? productDescription;

  //local
  bool get isDiscount => discountValue != 0;

  ProductData({
    this.brandId,
    this.brandName,
    this.category,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.description,
    this.discountEndDate,
    this.discountStartDate,
    this.discountType,
    this.discountValue,
    this.id,
    this.inWishlist,
    this.maxPrice,
    this.minPrice,
    this.name,
    this.productImage,
    this.sellTarget,
    this.shortDescription,
    this.slug,
    this.stockQty,
    this.unitId,
    this.unitName,
    this.updatedAt,
    this.updatedBy,
    this.taxIncludeMinPrice,
    this.taxIncludeMaxPrice,
    this.minDiscountedProductAmount,
    this.maxDiscountedProductAmount,
    this.isPublished,
    this.minPurchaseQty,
    this.maxPurchaseQty,
    this.hasVariation,
    this.hasWarranty,
    this.variationData,
    this.productGallaryData,
    this.productReview,
    this.status,
    this.ratingCount,
    this.rating,
    this.userId,
    this.productId,
    this.productName,
    this.productDescription,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      brandId: json['brand_id'],
      brandName: json['brand_name'],
      category: json['category'] != null ? (json['category'] as List).map((i) => CategoryData.fromJson(i)).toList() : null,
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      description: json['description'],
      discountEndDate: json['discount_end_date'],
      discountStartDate: json['discount_start_date'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      id: json['id'],
      inWishlist: json['in_wishlist'],
      maxPrice: json['max_price'],
      minPrice: json['min_price'],
      name: json['name'],
      productImage: json['product_image'],
      sellTarget: json['sell_target'],
      shortDescription: json['short_description'],
      slug: json['slug'],
      stockQty: json['stock_qty'],
      unitId: json['unit_id'],
      unitName: json['unit_name'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      taxIncludeMinPrice: json['tax_include_min_price'],
      taxIncludeMaxPrice: json['tax_include_max_price'],
      minDiscountedProductAmount: json['min_discounted_product_amount'],
      maxDiscountedProductAmount: json['max_discounted_product_amount'],
      isPublished: json['is_published'],
      minPurchaseQty: json['min_purchase_qty'],
      maxPurchaseQty: json['max_purchase_qty'],
      hasVariation: json['has_variation'],
      hasWarranty: json['has_warranty'],
      status: json['status'],
      ratingCount: json['rating_count'],
      rating: json['rating'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      variationData: json['variation_data'] != null ? (json['variation_data'] as List).map((i) => VariationData.fromJson(i)).toList() : null,
      productGallaryData: json['product_gallary'] != null ? new List<String>.from(json['product_gallary']) : null,
      productReview: json['product_review'] != null ? (json['product_review'] as List).map((i) => ProductReviewDataModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['description'] = this.description;
    data['discount_end_date'] = this.discountEndDate;
    data['discount_start_date'] = this.discountStartDate;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['id'] = this.id;
    data['in_wishlist'] = this.inWishlist;
    data['max_price'] = this.maxPrice;
    data['min_price'] = this.minPrice;
    data['name'] = this.name;
    data['product_image'] = this.productImage;
    data['sell_target'] = this.sellTarget;
    data['short_description'] = this.shortDescription;
    data['slug'] = this.slug;
    data['stock_qty'] = this.stockQty;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['tax_include_min_price'] = this.taxIncludeMinPrice;
    data['tax_include_max_price'] = this.taxIncludeMaxPrice;
    data['min_discounted_product_amount'] = this.minDiscountedProductAmount;
    data['max_discounted_product_amount'] = this.maxDiscountedProductAmount;
    data['is_published'] = this.isPublished;
    data['min_purchase_qty'] = this.minPurchaseQty;
    data['max_purchase_qty'] = this.maxPurchaseQty;
    data['has_variation'] = this.hasVariation;
    data['has_warranty'] = this.hasWarranty;
    data['deleted_at'] = this.deletedAt;
    data['deleted_by'] = this.deletedBy;
    data['status'] = this.status;
    data['rating_count'] = this.ratingCount;
    data['rating'] = this.rating;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.variationData != null) {
      data['variation_data'] = this.variationData!.map((v) => v.toJson()).toList();
    }
    if (this.productGallaryData != null) {
      data['product_gallary'] = this.productGallaryData;
    }
    if (this.productReview != null) {
      data['product_review'] = this.productReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationData {
  String? code;
  num? discountedProductPrice;
  int? id;
  num? productAmount;
  String? sku;
  num? taxIncludeProductPrice;
  int? variationKey;
  int? inCart;
  List<ProductCombinationData>? combination;

  ///cart list
  int? locationId;
  int? productStockQty;

  VariationData({
    this.code,
    this.discountedProductPrice,
    this.id,
    this.productAmount,
    this.sku,
    this.taxIncludeProductPrice,
    this.variationKey,
    this.inCart,
    this.locationId,
    this.productStockQty,
    this.combination,
  });

  factory VariationData.fromJson(Map<String, dynamic> json) {
    return VariationData(
      code: json['code'],
      discountedProductPrice: json['discounted_product_price'],
      id: json['id'],
      productAmount: json['product_amount'],
      sku: json['sku'],
      taxIncludeProductPrice: json['tax_include_product_price'],
      variationKey: json['variation_key'],
      inCart: json['in_cart'],
      locationId: json['location_id'],
      productStockQty: json['product_stock_qty'],
      combination: json['combination'] != null ? (json['combination'] as List).map((i) => ProductCombinationData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['discounted_product_price'] = this.discountedProductPrice;
    data['id'] = this.id;
    data['product_amount'] = this.productAmount;
    data['sku'] = this.sku;
    data['tax_include_product_price'] = this.taxIncludeProductPrice;
    data['variation_key'] = this.variationKey;
    data['in_cart'] = this.inCart;
    data['location_id'] = this.locationId;
    data['product_stock_qty'] = this.productStockQty;
    if (this.combination != null) {
      data['combination'] = this.combination!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCombinationData {
  int? id;
  String? productVariationName;
  String? productVariationType;
  String? productVariationValue;

  ProductCombinationData({this.id, this.productVariationName, this.productVariationType, this.productVariationValue});

  factory ProductCombinationData.fromJson(Map<String, dynamic> json) {
    return ProductCombinationData(
      id: json['id'],
      productVariationName: json['product_variation_name'],
      productVariationType: json['product_variation_type'],
      productVariationValue: json['product_variation_value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_variation_name'] = this.productVariationName;
    data['product_variation_type'] = this.productVariationType;
    data['product_variation_value'] = this.productVariationValue;
    return data;
  }
}
