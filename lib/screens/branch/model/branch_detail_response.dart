import 'branch_response.dart';

class BranchDetailResponse {
  BranchData? data;
  String? message;
  bool? status;

  BranchDetailResponse({this.data, this.message, this.status});

  factory BranchDetailResponse.fromJson(Map<String, dynamic> json) {
    return BranchDetailResponse(
      data: json['data'] != null ? BranchData.fromJson(json['data']) : null,
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
