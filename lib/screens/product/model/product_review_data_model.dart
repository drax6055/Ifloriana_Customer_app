class ProductReviewsResponse {
  List<ProductReviewDataModel>? data;
  String? message;
  bool? status;

  ProductReviewsResponse({this.data, this.message, this.status});

  factory ProductReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ProductReviewsResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => ProductReviewDataModel.fromJson(i)).toList() : null,
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

class ProductReviewDataModel {
  int? id;
  int? productId;
  int? rating;
  int? reviewDislikes;
  int? isUserLike;
  int? isUserDislike;
  List<ReviewGallaryData>? reviewGallary;
  int? reviewLikes;
  String? reviewMsg;
  int? userId;
  String? userName;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;

  ///order detail
  String? featureImage;
  List<ReviewGallaryData>? gallery;
  int? productVariationId;

  ProductReviewDataModel({
    this.id,
    this.productId,
    this.rating,
    this.reviewDislikes,
    this.isUserLike,
    this.isUserDislike,
    this.reviewGallary,
    this.reviewLikes,
    this.reviewMsg,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.featureImage,
    this.gallery,
    this.productVariationId,
  });

  factory ProductReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewDataModel(
      id: json['id'],
      productId: json['product_id'],
      rating: json['rating'],
      reviewDislikes: json['review_dislikes'],
      isUserLike: json['is_user_like'],
      isUserDislike: json['is_user_dislike'],
      reviewGallary: json['review_gallary'] != null ? (json['review_gallary'] as List).map((i) => ReviewGallaryData.fromJson(i)).toList() : null,
      reviewLikes: json['review_likes'],
      reviewMsg: json['review_msg'],
      userId: json['user_id'],
      userName: json['user_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      featureImage: json['feature_image'],
      gallery: json['gallery'] != null ? (json['gallery'] as List).map((i) => ReviewGallaryData.fromJson(i)).toList() : null,
      productVariationId: json['product_variation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['rating'] = this.rating;
    data['review_dislikes'] = this.reviewDislikes;
    data['is_user_like'] = this.isUserLike;
    data['is_user_dislike'] = this.isUserDislike;
    data['review_likes'] = this.reviewLikes;
    data['review_msg'] = this.reviewMsg;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviewGallary != null) {
      data['review_gallary'] = this.reviewGallary!.map((v) => v.toJson()).toList();
    }
    if (this.deletedAt != null) {
      data['deleted_at'] = this.deletedAt;
    }
    return data;
  }
}

class ReviewGallaryData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  String? fullUrl;
  int? id;
  int? reviewId;
  int? status;
  String? updatedAt;
  int? updatedBy;

  ReviewGallaryData({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.fullUrl, this.id, this.reviewId, this.status, this.updatedAt, this.updatedBy});

  factory ReviewGallaryData.fromJson(Map<String, dynamic> json) {
    return ReviewGallaryData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      fullUrl: json['full_url'],
      id: json['id'],
      reviewId: json['review_id'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['full_url'] = this.fullUrl;
    data['id'] = this.id;
    data['review_id'] = this.reviewId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    if (this.deletedAt != null) {
      data['deleted_at'] = this.deletedAt;
    }
    if (this.deletedBy != null) {
      data['deleted_by'] = this.deletedBy;
    }
    return data;
  }
}

class ProductReviewLikeDislikeModel {
  int? dislikeCount;
  int? likeCount;
  String? message;
  bool? status;

  ProductReviewLikeDislikeModel({this.dislikeCount, this.likeCount, this.message, this.status});

  factory ProductReviewLikeDislikeModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewLikeDislikeModel(
      dislikeCount: json['dislike_count'],
      likeCount: json['like_count'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dislike_count'] = this.dislikeCount;
    data['like_count'] = this.likeCount;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}