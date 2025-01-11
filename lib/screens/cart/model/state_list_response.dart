class StateListResponse {
  List<StateData>? data;
  String? message;
  bool? status;

  StateListResponse({this.data, this.message, this.status});

  factory StateListResponse.fromJson(Map<String, dynamic> json) {
    return StateListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => StateData.fromJson(i)).toList() : null,
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

class StateData {
  int? countryId;
  int? id;
  String? name;

  StateData({this.countryId, this.id, this.name});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      countryId: json['country_id'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
