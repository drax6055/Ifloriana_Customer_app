import 'package:ifloriana/models/review_data.dart';

class EmployeeReviewResponse {
  List<ReviewData>? reviewData;
  String? message;
  bool? status;

  EmployeeReviewResponse({this.reviewData, this.message, this.status});

  factory EmployeeReviewResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeReviewResponse(
      reviewData: json['data'] != null ? (json['data'] as List).map((i) => ReviewData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.reviewData != null) {
      data['data'] = this.reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
