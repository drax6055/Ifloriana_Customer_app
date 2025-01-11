import '../../services/models/service_response.dart';

class BranchServiceListResponse {
  List<ServiceListData>? data;
  String? message;
  bool? status;

  BranchServiceListResponse({this.data, this.message, this.status});

  factory BranchServiceListResponse.fromJson(Map<String, dynamic> json) {
    return BranchServiceListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => ServiceListData.fromJson(i)).toList() : null,
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
