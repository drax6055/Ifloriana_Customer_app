class OrderStatusResponse {
  List<OrderStatusData>? data;
  String? message;
  bool? status;

  OrderStatusResponse({this.data, this.message, this.status});

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => OrderStatusData.fromJson(i)).toList() : null,
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

class OrderStatusData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  int? sequence;
  int? status;
  String? subType;
  String? type;
  String? updatedAt;
  int? updatedBy;
  String? value;

  OrderStatusData({
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.name,
    this.sequence,
    this.status,
    this.subType,
    this.type,
    this.updatedAt,
    this.updatedBy,
    this.value,
  });

  factory OrderStatusData.fromJson(Map<String, dynamic> json) {
    return OrderStatusData(
      createdAt: json['created_at'],
      createdBy: json['created_by'] != null ? json['created_by'] : null,
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      id: json['id'],
      name: json['name'],
      sequence: json['sequence'],
      status: json['status'],
      subType: json['sub_type'] != null ? json['sub_type'] : null,
      type: json['type'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'] != null ? json['updated_by'] : null,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['sequence'] = this.sequence;
    data['status'] = this.status;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['value'] = this.value;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy;
    }
    if (this.deletedAt != null) {
      data['deleted_at'] = this.deletedAt;
    }
    if (this.deletedBy != null) {
      data['deleted_by'] = this.deletedBy;
    }
    if (this.subType != null) {
      data['sub_type'] = this.subType;
    }
    if (this.updatedBy != null) {
      data['updated_by'] = this.updatedBy;
    }
    return data;
  }
}
