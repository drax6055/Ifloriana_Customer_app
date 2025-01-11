import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/services/models/service_response.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/review_data.dart';
import '../../../utils/common_base.dart';
import '../../cart/model/cart_list_response.dart';
import 'booking_detail_response.dart';

class BookingListResponse {
  List<BookingListData>? data;
  String? message;
  bool? status;

  BookingListResponse({this.data, this.message, this.status});

  factory BookingListResponse.fromJson(Map<String, dynamic> json) {
    return BookingListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => BookingListData.fromJson(i)).toList() : null,
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

class BookingListData {
  String? branchName;
  String? createdAt;
  String? createdByName;
  String? employeeName;
  String? employeeImage;
  int? id;
  String? note;
  String? startDateTime;
  String? status;
  String? updatedAt;
  String? updatedByName;
  String? userCreated;
  String? userName;
  String? userProfileImage;

  String? addressLine1;
  String? addressLine2;
  int? branchId;
  int? employeeId;
  String? phone;
  int? userId;
  ReviewData? customerReview;
  List<ServiceListData>? serviceList;
  List<Packages>? packages;
  num? discount;
  num? tip;
  num? couponAmount;
  Payment? payment;
  List<ProductsInfo>? productsInfo;
  num? discoutAmount;
  num? sumOfServicePrices;
  num? sumOfProductPrices;
  num? sumOfPackagesPrices;
  num? taxAmount;
  num? totalAmount;
  List<TaxDetail>? taxDetails;

  // local
  DateTime get bookingDateTime => DateTime.parse(startDateTime.validate());

  String get bookingDate => formatDate(bookingDateTime.toString(), format: DateFormatConst.BOOK_DATE_FORMAT);

  String get bookingTime => formatDate(bookingDateTime.toString(), format: DateFormatConst.HOUR_12_FORMAT);

  String get statusLabel => status.validate().getBookingStatusLabel;

  // Local Variable for booking the appointment
  String? date;
  String? time;
  List<ServiceListData>? selectedServiceList;

  BookingListData({
    this.branchName,
    this.createdAt,
    this.createdByName,
    this.employeeName,
    this.employeeImage,
    this.id,
    this.note,
    this.startDateTime,
    this.status,
    this.updatedAt,
    this.updatedByName,
    this.couponAmount,
    this.userCreated,
    this.userName,
    this.userProfileImage,
    this.addressLine1,
    this.addressLine2,
    this.branchId,
    this.employeeId,
    this.phone,
    this.userId,
    this.customerReview,
    this.discount,
    this.tip,
    this.payment,
    this.serviceList,
    this.packages,
    this.sumOfPackagesPrices,
    this.productsInfo,
    this.discoutAmount,
    this.sumOfServicePrices,
    this.sumOfProductPrices,
    this.taxAmount,
    this.totalAmount,
    this.taxDetails,
  });

  factory BookingListData.fromJson(Map<String, dynamic> json) {
    return BookingListData(
      branchName: json['branch_name'],
      createdAt: json['created_at'],
      createdByName: json['created_by_name'],
      employeeName: json['employee_name'],
      employeeImage: json['employee_image'],
      id: json['id'],
      note: json['note'] != null ? json['note'] : null,
      startDateTime: json['start_date_time'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedByName: json['updated_by_name'],
      userCreated: json['user_created'],
      userName: json['user_name'],
      userProfileImage: json['user_profile_image'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      branchId: json['branch_id'],
      couponAmount: json['coupon_amount'],
      employeeId: json['employee_id'] is String ? 0 : json['employee_id'],
      phone: json['phone'],
      userId: json['user_id'],
      customerReview: json['customer_review'] != null ? ReviewData.fromJson(json['customer_review']) : null,
      discount: json['discount'],
      tip: json['tip'],
      payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      serviceList: json['services'] != null ? (json['services'] as List).map((i) => ServiceListData.fromJson(i)).toList() : null,
      packages: json['packages'] != null ? (json['packages'] as List).map((i) => Packages.fromJson(i)).toList() : null,
      productsInfo: json['products'] != null ? (json['products'] as List).map((i) => ProductsInfo.fromJson(i)).toList() : null,
      sumOfServicePrices: json['sumOfServicePrices'],
      sumOfPackagesPrices: json['sumOfPackagesPrices'],
      sumOfProductPrices: json['sumOfProductPrices'],
      discoutAmount: json['discout_amount'],
      taxAmount: json['tax_amount'],
      totalAmount: json['total_amount'],
      taxDetails: json['tax_details'] != null ? (json['tax_details'] as List).map((i) => TaxDetail.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    data['created_by_name'] = this.createdByName;
    data['employee_image'] = this.employeeImage;
    data['id'] = this.id;
    data['start_date_time'] = this.startDateTime;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['updated_by_name'] = this.updatedByName;
    data['user_created'] = this.userCreated;
    data['user_name'] = this.userName;
    data['user_profile_image'] = this.userProfileImage;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['branch_id'] = this.branchId;
    data['employee_id'] = this.employeeId;
    data['phone'] = this.phone;
    data['coupon_amount'] = this.couponAmount;
    data['user_id'] = this.userId;
    data['discount'] = this.discount;
    data['tip'] = this.tip;
    data['sumOfServicePrices'] = this.sumOfServicePrices;
    data['sumOfPackagesPrices'] = this.sumOfPackagesPrices;
    data['sumOfProductPrices'] = this.sumOfProductPrices;
    data['discout_amount'] = this.discoutAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_amount'] = this.totalAmount;
    if (this.note != null) {
      data['note'] = this.note;
    }
    if (this.customerReview != null) {
      data['customer_review'] = this.customerReview!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.serviceList != null) {
      data['services'] = this.serviceList!.map((v) => v.toJson()).toList();
    }
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    if (this.productsInfo != null) {
      data['products'] = this.productsInfo!.map((v) => v.toJson()).toList();
    }
    if (this.taxDetails != null) {
      data['tax_data'] = this.taxDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// For Save Booking
  Map<String, dynamic> toBookingJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (employeeId != null) data['employee_id'] = this.employeeId;
    if (date != null) data['date'] = this.date;
    if (time != null) data['time'] = this.time.validate();
    data['branch_id'] = appStore.branchId;

    if (this.selectedServiceList != null) {
      data['services'] = this.selectedServiceList.validate().map((e) => e.toBookingServiceJson()).toList();
    }

    return data;
  }
}

class Packages {
  Packages({
    this.id,
    this.packageName,
    this.startDate,
    this.endDate,
    this.description,
    this.image,
    this.branchId,
    this.branchName,
    this.packagePrice,
    this.isReclaim,
    this.services,});

  Packages.fromJson(dynamic json) {
    id = json['id'];
    packageName = json['package_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    image = json['image'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    packagePrice = json['package_price'];
    isReclaim = json['is_reclaim'];

    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
  }
  num? id;
  String? packageName;
  String? startDate;
  String? endDate;
  String? description;
  String? image;
  num? branchId;
  String? branchName;
  num? packagePrice;
  num? isReclaim;
  List<Services>? services;
  Packages copyWith({  num? id,
    String? packageName,
    String? startDate,
    String? endDate,
    String? description,
    String? image,
    num? branchId,
    String? branchName,
    num? packagePrice,
    num? isReclaim,
    List<Services>? services,
  }) => Packages(  id: id ?? this.id,
    packageName: packageName ?? this.packageName,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    description: description ?? this.description,
    image: image ?? this.image,
    branchId: branchId ?? this.branchId,
    branchName: branchName ?? this.branchName,
    packagePrice: packagePrice ?? this.packagePrice,
    isReclaim: isReclaim ?? this.isReclaim,
    services: services ?? this.services,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['package_name'] = packageName;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['description'] = description;
    map['image'] = image;
    map['branch_id'] = branchId;
    map['branch_name'] = branchName;
    map['package_price'] = packagePrice;
    map['is_reclaim'] = isReclaim;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Services {
  Services({
    this.id,
    this.serviceId,
    this.serviceName,
    this.durationMin,
    this.serviceImage,
    this.totalQty,
    this.remainingQty,
    this.servicePrice,});

  Services.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    durationMin = json['duration_min'];
    serviceImage = json['service_image'];
    totalQty = json['total_qty'];
    remainingQty = json['remaining_qty'];
    servicePrice = json['service_price'];
  }
  num? id;
  num? serviceId;
  String? serviceName;
  num? durationMin;
  String? serviceImage;
  num? totalQty;
  num? remainingQty;
  num? servicePrice;
  Services copyWith({  num? id,
    num? serviceId,
    String? serviceName,
    num? durationMin,
    String? serviceImage,
    num? totalQty,
    num? remainingQty,
    num? servicePrice,
  }) => Services(  id: id ?? this.id,
    serviceId: serviceId ?? this.serviceId,
    serviceName: serviceName ?? this.serviceName,
    durationMin: durationMin ?? this.durationMin,
    serviceImage: serviceImage ?? this.serviceImage,
    totalQty: totalQty ?? this.totalQty,
    remainingQty: remainingQty ?? this.remainingQty,
    servicePrice: servicePrice ?? this.servicePrice,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['service_name'] = serviceName;
    map['duration_min'] = durationMin;
    map['service_image'] = serviceImage;
    map['total_qty'] = totalQty;
    map['remaining_qty'] = remainingQty;
    map['service_price'] = servicePrice;
    return map;
  }

}
