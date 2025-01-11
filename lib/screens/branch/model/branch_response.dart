import 'package:flutter/material.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';

class BranchResponse {
  List<BranchData>? data;
  String? message;
  bool? status;

  BranchResponse({this.data, this.message, this.status});

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => BranchData.fromJson(i)).toList() : null,
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

class BranchData {
  String? addressLine1;
  String? branchFor;
  String? contactEmail;
  String? contactNumber;
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  num? latitude;
  num? longitude;
  int? managerId;
  String? name;
  List<String>? paymentMethod;
  num? ratingStar;
  String? slug;
  int? status;
  String? updatedAt;
  int? updatedBy;
  String? branchImg;
  String? description;
  int? totalReview;

  List<WorkingHourList>? workingHourList;

  ///LOCAL
  WorkingHourList? get todayTime =>
      workingHourList.validate().isNotEmpty ? workingHourList!.firstWhere((element) => element.day.validate().toLowerCase().getWeekDayCount == DateTime.now().weekday.validate()) : null;

  Color? get ratingColor => getRatingBarColor(ratingStar.validate().toInt());

  BranchData({
    this.addressLine1,
    this.branchFor,
    this.contactEmail,
    this.contactNumber,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.latitude,
    this.longitude,
    this.managerId,
    this.name,
    this.paymentMethod,
    this.ratingStar,
    this.slug,
    this.status,
    this.updatedAt,
    this.updatedBy,
    this.branchImg,
    this.totalReview,
    this.description,
    this.workingHourList,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      addressLine1: json['address_line_1'],
      branchFor: json['branch_for'],
      contactEmail: json['contact_email'],
      contactNumber: json['contact_number'],
      createdAt: json['created_at'],
      createdBy: json['created_by'] != null ? json['created_by'] : null,
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      deletedBy: json['deleted_by'] != null ? json['deleted_by'] : null,
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      managerId: json['manager_id'],
      name: json['name'],
      paymentMethod: json['payment_method'] != null ? new List<String>.from(json['payment_method']) : null,
      ratingStar: json['rating_star'] != null ? json['rating_star'] : null,
      slug: json['slug'],
      status: json['status'],
      updatedAt: json['updated_at'],
      totalReview: json['total_review'],
      updatedBy: json['updated_by'] != null ? json['updated_by'] : null,
      branchImg: json['branch_image'] != null ? json['branch_image'] : null,
      description: json['description'] != null ? json['description'] : null,
      workingHourList: json['working_days'] != null ? (json['working_days'] as List).map((e) => WorkingHourList.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line_1'] = this.addressLine1;
    data['branch_for'] = this.branchFor;
    data['contact_email'] = this.contactEmail;
    data['contact_number'] = this.contactNumber;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['manager_id'] = this.managerId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['total_review'] = this.totalReview;
    data['description'] = this.description;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy;
    }
    if (this.deletedAt != null) {
      data['deleted_at'] = this.deletedAt;
    }
    if (this.deletedBy != null) {
      data['deleted_by'] = this.deletedBy;
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod;
    }
    if (this.ratingStar != null) {
      data['rating_start'] = this.ratingStar;
    }
    if (this.updatedBy != null) {
      data['updated_by'] = this.updatedBy;
    }
    if (this.branchImg != null) {
      data['branch_image'] = this.branchImg;
    }
    if (this.workingHourList != null) {
      data['working_days'] = this.workingHourList;
    }
    return data;
  }
}

class WorkingHourList {
  String? day;
  String? endTime;
  int? isHoliday;
  String? startTime;
  List<BranchBreaks>? branchBreaks;

  WorkingHourList({this.day, this.endTime, this.isHoliday, this.startTime, this.branchBreaks});

  factory WorkingHourList.fromJson(Map<String, dynamic> json) {
    return WorkingHourList(
      day: json['day'],
      endTime: json['end_time'],
      isHoliday: json['is_holiday'],
      startTime: json['start_time'],
      branchBreaks: json['breaks'] != null ? (json['breaks'] as List).map((i) => BranchBreaks.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['end_time'] = this.endTime;
    data['is_holiday'] = this.isHoliday;
    data['start_time'] = this.startTime;
    if (this.branchBreaks != null) {
      data['breaks'] = data['breaks'] = this.branchBreaks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchBreaks {
  String? startBreak;
  String? endBreak;

  BranchBreaks({this.startBreak, this.endBreak});

  factory BranchBreaks.fromJson(Map<String, dynamic> json) {
    return BranchBreaks(
      startBreak: json['start_break'],
      endBreak: json['end_break'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_break'] = this.startBreak;
    data['end_break'] = this.endBreak;
    return data;
  }
}
