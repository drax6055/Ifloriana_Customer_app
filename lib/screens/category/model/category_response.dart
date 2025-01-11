class CategoryResponse {
  List<CategoryData>? category;
  String? message;
  bool? status;

  CategoryResponse({this.category, this.message, this.status});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      category: json['data'] != null ? (json['data'] as List).map((i) => CategoryData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.category != null) {
      data['data'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  int? parentId;
  String? slug;
  int? status;
  String? updatedAt;
  int? updatedBy;
  String? categoryImage;

  /// Product Module
  int? brandId;

  CategoryData({
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.name,
    this.parentId,
    this.brandId,
    this.slug,
    this.status,
    this.updatedAt,
    this.updatedBy,
    this.categoryImage,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      createdAt: json['created_at'],
      createdBy: json['created_by'] != null ? json['created_by'] : null,
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'] != null ? json['parent_id'] : null,
      slug: json['slug'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'] != null ? json['updated_by'] : null,
      categoryImage: json['category_image'],
      brandId: json['brand_id'] != null ? json['brand_id'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['deleted_at'] = this.deletedAt;
    data['deleted_by'] = this.deletedBy;
    data['parent_id'] = this.parentId;
    data['updated_by'] = this.updatedBy;
    data['category_image'] = this.categoryImage;
    data['brand_id'] = this.brandId;
    return data;
  }
}
