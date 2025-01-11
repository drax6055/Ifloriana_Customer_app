class LogisticZoneResponse {
  List<LogisticZoneData>? data;
  String? message;
  bool? status;

  LogisticZoneResponse({this.data, this.message, this.status});

  factory LogisticZoneResponse.fromJson(Map<String, dynamic> json) {
    return LogisticZoneResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => LogisticZoneData.fromJson(i)).toList() : null,
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

class LogisticZoneData {
  List<CityData>? cities;
  int? countryId;
  num? expressDeliveryCharge;
  String? expressDeliveryTime;
  int? id;
  int? logisticId;
  String? logisticName;
  String? name;
  num? standardDeliveryCharge;
  String? standardDeliveryTime;
  int? stateId;
  bool isLogisticCheck;

  LogisticZoneData({
    this.cities,
    this.countryId,
    this.expressDeliveryCharge,
    this.expressDeliveryTime,
    this.id,
    this.logisticId,
    this.logisticName,
    this.name,
    this.standardDeliveryCharge,
    this.standardDeliveryTime,
    this.stateId,
    this.isLogisticCheck = false,
  });

  factory LogisticZoneData.fromJson(Map<String, dynamic> json) {
    return LogisticZoneData(
      cities: json['cities'] != null ? (json['cities'] as List).map((i) => CityData.fromJson(i)).toList() : null,
      countryId: json['country_id'],
      expressDeliveryCharge: json['express_delivery_charge'],
      expressDeliveryTime: json['express_delivery_time'] != null ? json['express_delivery_time'] : null,
      id: json['id'],
      logisticId: json['logistic_id'],
      logisticName: json['logistic_name'],
      name: json['name'],
      standardDeliveryCharge: json['standard_delivery_charge'],
      standardDeliveryTime: json['standard_delivery_time'] != null ? json['standard_delivery_time'] : null,
      stateId: json['state_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['express_delivery_charge'] = this.expressDeliveryCharge;
    data['id'] = this.id;
    data['logistic_id'] = this.logisticId;
    data['logistic_name'] = this.logisticName;
    data['name'] = this.name;
    data['standard_delivery_charge'] = this.standardDeliveryCharge;
    data['state_id'] = this.stateId;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.expressDeliveryTime != null) {
      data['express_delivery_time'] = this.expressDeliveryTime;
    }
    if (this.standardDeliveryTime != null) {
      data['standard_delivery_time'] = this.standardDeliveryTime;
    }
    return data;
  }
}

class CityData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  Pivot? pivot;
  int? stateId;
  int? status;
  String? updatedAt;
  int? updatedBy;

  CityData({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.id, this.name, this.pivot, this.stateId, this.status, this.updatedAt, this.updatedBy});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      createdAt: json['created_at'],
      createdBy: json['created_by'] != null ? json['created_by'] : null,
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      id: json['id'],
      name: json['name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      stateId: json['state_id'],
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
    data['state_id'] = this.stateId;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot;
    }
    if (this.updatedBy != null) {
      data['updated_by'] = this.updatedBy;
    }
    return data;
  }
}

class Pivot {
  int? cityId;
  int? logisticZoneId;

  Pivot({this.cityId, this.logisticZoneId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      cityId: json['city_id'],
      logisticZoneId: json['logistic_zone_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['logistic_zone_id'] = this.logisticZoneId;
    return data;
  }
}
