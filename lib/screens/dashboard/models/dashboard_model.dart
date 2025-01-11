import 'package:ifloriana/screens/dashboard/models/slider_data.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';

import '../../category/model/category_response.dart';
import '../../experts/model/employee_detail_response.dart';
import '../../services/models/service_response.dart';

class DashboardResponse {
  DashboardData? data;
  String? message;
  bool? status;
  List<PackageListData>? expiringPackagesList;
  List<PackageListData>? packagesList;


  DashboardResponse({this.data, this.message, this.status,this.packagesList, this.expiringPackagesList});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
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

class DashboardData {
  List<CategoryData>? category;
  List<ServiceListData>? service;
  List<EmployeeData>? topExperts;
  List<SliderData>? sliderData;

  DashboardData({this.category, this.service, this.topExperts, this.sliderData});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      category: json['category'] != null ? (json['category'] as List).map((i) => CategoryData.fromJson(i)).toList() : null,
      service: json['service'] != null ? (json['service'] as List).map((i) => ServiceListData.fromJson(i)).toList() : null,
      topExperts: json['top_experts'] != null ? (json['top_experts'] as List).map((i) => EmployeeData.fromJson(i)).toList() : null,
      sliderData: json['slider'] != null ? (json['slider'] as List).map((i) => SliderData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    if (this.topExperts != null) {
      data['topExperts'] = this.topExperts!.map((v) => v.toJson()).toList();
    }
    if (this.topExperts != null) {
      data['slider'] = this.topExperts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
