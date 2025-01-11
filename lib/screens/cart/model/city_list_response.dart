import 'package:ifloriana/screens/cart/model/logistic_zone_response.dart';

class CityListResponse {
  List<CityData>? data;
  String? message;
  bool? status;

  CityListResponse({this.data, this.message, this.status});

  factory CityListResponse.fromJson(Map<String, dynamic> json) {
    return CityListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => CityData.fromJson(i)).toList() : null,
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
