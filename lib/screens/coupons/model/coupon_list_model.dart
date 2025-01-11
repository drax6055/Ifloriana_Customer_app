class CouponListModel {
  CouponListModel({
      this.status, 
      this.couponListData,
      this.message,});

  CouponListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      couponListData = [];
      json['data'].forEach((v) {
        couponListData?.add(CouponListData.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<CouponListData>? couponListData;
  String? message;
CouponListModel copyWith({  bool? status,
  List<CouponListData>? data,
  String? message,
}) => CouponListModel(  status: status ?? this.status,
  couponListData: data ?? this.couponListData,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (couponListData != null) {
      map['data'] = couponListData?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class CouponListData {
  CouponListData({
      this.id, 
      this.name, 
      this.description, 
      this.couponImage, 
      this.couponCode, 
      this.couponType, 
      this.startDateTime, 
      this.endDateTime, 
      this.isExpired, 
      this.discountType, 
      this.discountPercentage, 
      this.discountAmount, 
      this.useLimit, 
      this.usedBy, 
      this.promotionId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  CouponListData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    couponImage = json['coupon_image'];
    couponCode = json['coupon_code'];
    couponType = json['coupon_type'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    isExpired = json['is_expired'];
    discountType = json['discount_type'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    useLimit = json['use_limit'];
    usedBy = json['used_by'];
    promotionId = json['promotion_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  num? id;
  String? name;
  String? description;
  String? couponImage;
  String? couponCode;
  dynamic couponType;
  String? startDateTime;
  String? endDateTime;
  num? isExpired;
  String? discountType;
  num? discountPercentage;
  num? discountAmount;
  num? useLimit;
  dynamic usedBy;
  num? promotionId;
  num? createdBy;
  num? updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
CouponListData copyWith({  num? id,
  String? name,
  String? description,
  String? couponImage,
  String? couponCode,
  dynamic couponType,
  String? startDateTime,
  String? endDateTime,
  num? isExpired,
  String? discountType,
  num? discountPercentage,
  num? discountAmount,
  num? useLimit,
  dynamic usedBy,
  num? promotionId,
  num? createdBy,
  num? updatedBy,
  dynamic deletedBy,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => CouponListData(  id: id ?? this.id,
  name: name ?? this.name,
  description: description ?? this.description,
  couponImage: couponImage ?? this.couponImage,
  couponCode: couponCode ?? this.couponCode,
  couponType: couponType ?? this.couponType,
  startDateTime: startDateTime ?? this.startDateTime,
  endDateTime: endDateTime ?? this.endDateTime,
  isExpired: isExpired ?? this.isExpired,
  discountType: discountType ?? this.discountType,
  discountPercentage: discountPercentage ?? this.discountPercentage,
  discountAmount: discountAmount ?? this.discountAmount,
  useLimit: useLimit ?? this.useLimit,
  usedBy: usedBy ?? this.usedBy,
  promotionId: promotionId ?? this.promotionId,
  createdBy: createdBy ?? this.createdBy,
  updatedBy: updatedBy ?? this.updatedBy,
  deletedBy: deletedBy ?? this.deletedBy,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['coupon_image'] = couponImage;
    map['coupon_code'] = couponCode;
    map['coupon_type'] = couponType;
    map['start_date_time'] = startDateTime;
    map['end_date_time'] = endDateTime;
    map['is_expired'] = isExpired;
    map['discount_type'] = discountType;
    map['discount_percentage'] = discountPercentage;
    map['discount_amount'] = discountAmount;
    map['use_limit'] = useLimit;
    map['used_by'] = usedBy;
    map['promotion_id'] = promotionId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['deleted_by'] = deletedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}