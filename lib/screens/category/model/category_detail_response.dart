class CategoryDetailResponse {
    CategoryDetail? data;
    String? message;
    bool? status;

    CategoryDetailResponse({this.data, this.message, this.status});

    factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) {
        return CategoryDetailResponse(
            data: json['data'] != null ? CategoryDetail.fromJson(json['data']) : null,
            message: json['message'], 
            status: json['status'], 
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

class CategoryDetail {
    String? createdAt;
    String? createdBy;
    String? deletedAt;
    String? deletedBy;
    int? id;
    String? name;
    String? parentId;
    String? slug;
    int? status;
    String? updatedAt;
    String? updatedBy;

    CategoryDetail({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.id, this.name, this.parentId, this.slug, this.status, this.updatedAt, this.updatedBy});

    factory CategoryDetail.fromJson(Map<String, dynamic> json) {
        return CategoryDetail(
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
        if (this.createdBy != null) {
            data['created_by'] = this.createdBy;
        }
        if (this.deletedAt != null) {
            data['deleted_at'] = this.deletedAt;
        }
        if (this.deletedBy != null) {
            data['deleted_by'] = this.deletedBy;
        }
        if (this.parentId != null) {
            data['parent_id'] = this.parentId;
        }
        if (this.updatedBy != null) {
            data['updated_by'] = this.updatedBy;
        }
        return data;
    }
}