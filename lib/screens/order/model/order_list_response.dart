import 'order_detail_response.dart';

class OrderListResponse {
  List<OrderListData>? data;
  String? message;
  bool? status;

  OrderListResponse({this.data, this.message, this.status});

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    return OrderListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => OrderListData.fromJson(i)).toList() : null,
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
