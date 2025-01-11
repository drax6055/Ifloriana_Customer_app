import '../../experts/model/employee_detail_response.dart';

class BranchEmployeeListResponse {
    List<EmployeeData>? data;
    String? message;
    bool? status;

    BranchEmployeeListResponse({this.data, this.message, this.status});

    factory BranchEmployeeListResponse.fromJson(Map<String, dynamic> json) {
        return BranchEmployeeListResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => EmployeeData.fromJson(i)).toList() : null,
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
