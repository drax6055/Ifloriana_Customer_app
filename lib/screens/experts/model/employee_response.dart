import 'employee_detail_response.dart';

class EmployeeResponse {
  List<EmployeeData>? topExperts;
  String? message;
  bool? status;

  EmployeeResponse({this.topExperts, this.message, this.status});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      topExperts: json['data'] != null ? (json['data'] as List).map((i) => EmployeeData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.topExperts != null) {
      data['data'] = this.topExperts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

