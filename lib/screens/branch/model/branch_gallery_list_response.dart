class BranchGalleryListResponse {
    List<BranchGalleryData>? data;
    String? message;
    bool? status;

    BranchGalleryListResponse({this.data, this.message, this.status});

    factory BranchGalleryListResponse.fromJson(Map<String, dynamic> json) {
        return BranchGalleryListResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => BranchGalleryData.fromJson(i)).toList() : null, 
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

class BranchGalleryData {
    int? branchId;
    String? createdAt;
    int? createdBy;
    int? deletedAt;
    int? deletedBy;
    String? fullUrl;
    int? id;
    int? status;
    String? updatedAt;
    int? updatedBy;

    BranchGalleryData({this.branchId, this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.fullUrl, this.id, this.status, this.updatedAt, this.updatedBy});

    factory BranchGalleryData.fromJson(Map<String, dynamic> json) {
        return BranchGalleryData(
            branchId: json['branch_id'], 
            createdAt: json['created_at'], 
            createdBy: json['created_by'], 
            deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
            deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
            fullUrl: json['full_url'], 
            id: json['id'], 
            status: json['status'], 
            updatedAt: json['updated_at'], 
            updatedBy: json['updated_by'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['branch_id'] = this.branchId;
        data['created_at'] = this.createdAt;
        data['created_by'] = this.createdBy;
        data['full_url'] = this.fullUrl;
        data['id'] = this.id;
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