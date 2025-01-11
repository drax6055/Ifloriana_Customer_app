class PackageListModel {
  bool status;
  List<PackageListData> packageListData;
  List<PackageListData> userPackageListData;
  String message;

  PackageListModel({
    this.status = false,
    this.packageListData = const <PackageListData>[],
    this.userPackageListData = const <PackageListData>[],
    this.message = "",
  });

  factory PackageListModel.fromJson(Map<String, dynamic> json) {
    return PackageListModel(
      status: json['status'] is bool ? json['status'] : false,
      packageListData: json['data'] is List ? List<PackageListData>.from(json['data'].map((x) => PackageListData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
      userPackageListData: json["userPackage"] is List ? List<PackageListData>.from(json["userPackage"]) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': packageListData.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class PackageListData {
  int id;
  String name;
  String description;
  int branchId;
  String branchName;
  int packagePrice;
  int status;
  String startDate;
  String endDate;
  int isFeatured;
  List<Services> services;
  List<UserPackage> userPackage;

  bool get isPurchased => userPackage.isNotEmpty;

  PackageListData({
    this.id = -1,
    this.name = "",
    this.description = "",
    this.branchId = -1,
    this.branchName = "",
    this.packagePrice = -1,
    this.status = -1,
    this.startDate = "",
    this.endDate = "",
    this.isFeatured = -1,
    this.services = const <Services>[],
    this.userPackage = const <UserPackage>[],
  });

  factory PackageListData.fromJson(Map<String, dynamic> json) {
    return PackageListData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      branchId: json['branch_id'] is int ? json['branch_id'] : -1,
      branchName: json['branch_name'] is String ? json['branch_name'] : "",
      packagePrice: json['package_price'] is int ? json['package_price'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      startDate: json['start_date'] is String ? json['start_date'] : "",
      endDate: json['end_date'] is String ? json['end_date'] : "",
      isFeatured: json['is_featured'] is int ? json['is_featured'] : -1,
      services: json['services'] is List ? List<Services>.from(json['services'].map((x) => Services.fromJson(x))) : [],
      userPackage: json['userPackage'] is List
          ? List<UserPackage>.from(
          json['userPackage'].map((x) => UserPackage.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'branch_id': branchId,
      'branch_name': branchName,
      'package_price': packagePrice,
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'is_featured': isFeatured,
      'services': services.map((e) => e.toJson()).toList(),
      'userPackage': userPackage.map((e) => e.toJson()).toList(),
    };
  }
}

class Services {
  Services({
    this.id,
    this.packageId,
    this.serviceId,
    this.qty,
    this.totalQty,
    this.remainingQty,
    this.servicePrice,
    this.discountedPrice,
    this.durationMin,
    this.serviceName,
  });

  Services.fromJson(dynamic json) {
    id = json['id'];
    packageId = json['package_id'];
    serviceId = json['service_id'];
    totalQty = json['total_qty'];
    qty = json['qty'];
    remainingQty = json['remaining_qty'];
    servicePrice = json['service_price'];
    discountedPrice = json['discounted_price'];
    durationMin = json['duration_min'];
    serviceName = json['service_name'];
  }

  num? id;
  num? packageId;
  num? serviceId;
  num? totalQty;
  num? qty;

  num? remainingQty;
  num? servicePrice;
  num? discountedPrice;
  num? durationMin;
  String? serviceName;

  Services copyWith({
    num? id,
    num? packageId,
    num? serviceId,
    num? totalQty,
    num? qty,
    num? remainingQty,
    num? servicePrice,
    num? discountedPrice,
    num? durationMin,
    String? serviceName,
  }) =>
      Services(
        id: id ?? this.id,
        qty: qty ?? this.qty,
        packageId: packageId ?? this.packageId,
        serviceId: serviceId ?? this.serviceId,
        totalQty: totalQty ?? this.totalQty,
        remainingQty: remainingQty ?? this.remainingQty,
        servicePrice: servicePrice ?? this.servicePrice,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        durationMin: durationMin ?? this.durationMin,
        serviceName: serviceName ?? this.serviceName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['package_id'] = packageId;
    map['service_id'] = serviceId;
    map['total_qty'] = totalQty;
    map['qty'] = qty;
    map['remaining_qty'] = remainingQty;
    map['service_price'] = servicePrice;
    map['discounted_price'] = discountedPrice;
    map['duration_min'] = durationMin;
    map['service_name'] = serviceName;
    return map;
  }
}

class UserPackage {
  int id;
  int bookingId;
  int employeeId;
  int packagePrice;
  int packageId;
  String purchaseDate;

  UserPackage({
    this.id = -1,
    this.bookingId = -1,
    this.employeeId = -1,
    this.packagePrice = -1,
    this.packageId = -1,
    this.purchaseDate = "",
  });

  factory UserPackage.fromJson(Map<String, dynamic> json) {
    return UserPackage(
      id: json['id'] is int ? json['id'] : -1,
      bookingId: json['booking_id'] is int ? json['booking_id'] : -1,
      employeeId: json['employee_id'] is int ? json['employee_id'] : -1,
      packagePrice: json['package_price'] is int ? json['package_price'] : -1,
      packageId: json['package_id'] is int ? json['package_id'] : -1,
      purchaseDate:
      json['purchase_date'] is String ? json['purchase_date'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'employee_id': employeeId,
      'package_price': packagePrice,
      'package_id': packageId,
      'purchase_date': purchaseDate,
    };
  }
}