import 'package:flutter/material.dart';

import '../../../models/review_data.dart';
import '../../../utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeDetailResponse {
  EmployeeData? data;
  String? message;
  bool? status;

  EmployeeDetailResponse({this.data, this.message, this.status});

  factory EmployeeDetailResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailResponse(
      data: json['data'] != null ? EmployeeData.fromJson(json['data']) : null,
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

class EmployeeData {
  String? profileImage;
  String? createdAt;
  String? dateOfBirth;
  String? deletedAt;
  String? email;
  String? emailVerifiedAt;
  String? firstName;
  String? fullName;
  String? gender;
  int? id;
  int? isBanned;
  int? isManager;
  String? lastName;
  String? mobile;
  String? playerId;
  int? showInCalender;
  int? status;
  String? updatedAt;
  String? expert;
  List<ReviewData>? reviewData;
  int? totalReview;

  int? branchesCount;
  int? serviceEmployeesCount;
  num? ratingStar;
  String? aboutSelf;
  String? joiningDate;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? dribbbleLink;

  Color? get ratingColor => getRatingBarColor(ratingStar.validate().toInt());

  ///For Booking Detail Response ( To show product info in booking detail )
  String? userName;
  String? loginType;
  String? webPlayerId;
  String? avatar;
  String? lastNotificationSeen;
  String? userSetting;
  int? isSubscribe;

  EmployeeData({
    this.profileImage,
    this.createdAt,
    this.dateOfBirth,
    this.deletedAt,
    this.email,
    this.emailVerifiedAt,
    this.firstName,
    this.fullName,
    this.gender,
    this.id,
    this.isBanned,
    this.isManager,
    this.lastName,
    this.mobile,
    this.playerId,
    this.showInCalender,
    this.status,
    this.updatedAt,
    this.expert,
    this.reviewData,
    this.totalReview,
    this.branchesCount,
    this.serviceEmployeesCount,
    this.ratingStar,
    this.aboutSelf,
    this.joiningDate,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.dribbbleLink,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      profileImage: json['profile_image'] != null ? json['profile_image'] : null,
      createdAt: json['created_at'],
      dateOfBirth: json['date_of_birth'] != null ? json['date_of_birth'] : null,
      deletedAt: json['deleted_at'] != null ? json['deleted_at'] : null,
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      gender: json['gender'],
      id: json['id'],
      isBanned: json['is_banned'],
      isManager: json['is_manager'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      playerId: json['player_id'] != null ? json['player_id'] : null,
      showInCalender: json['show_in_calender'],
      status: json['status'],
      updatedAt: json['updated_at'],
      expert: json['expert'],
      reviewData: json['review'] != null ? (json['review'] as List).map((i) => ReviewData.fromJson(i)).toList() : null,
      totalReview: json['total_review'],
      branchesCount: json['branches_count'],
      serviceEmployeesCount: json['service_employees_count'],
      ratingStar: json['rating_star'],
      aboutSelf: json['about_self'],
      joiningDate: json['joining_date'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      twitterLink: json['twitter_link'],
      dribbbleLink: json['dribbble_link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['first_name'] = this.firstName;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['is_banned'] = this.isBanned;
    data['is_manager'] = this.isManager;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['show_in_calender'] = this.showInCalender;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['expert'] = this.expert;
    data['branches_count'] = this.branchesCount;

    data['about_self'] = this.aboutSelf;
    data['joining_date'] = this.joiningDate;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['dribbble_link'] = this.dribbbleLink;
    data['total_review'] = this.totalReview;

    data['service_employees_count'] = this.serviceEmployeesCount;

    data['rating_star'] = this.ratingStar;

    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage;
    }
    if (this.dateOfBirth != null) {
      data['date_of_birth'] = this.dateOfBirth;
    }
    if (this.deletedAt != null) {
      data['deleted_at'] = this.deletedAt;
    }
    if (this.playerId != null) {
      data['player_id'] = this.playerId;
    }
    if (this.reviewData != null) {
      data['review'] = this.reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
