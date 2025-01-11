class BookingStatusResponse {
  List<BookingStatusData>? data;
  String? message;
  bool? status;
  String? link;

  BookingStatusResponse({this.data, this.message, this.status,this.link});

  factory BookingStatusResponse.fromJson(Map<String, dynamic> json) {
    return BookingStatusResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => BookingStatusData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['link'] = this.link;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingStatusData {
  String? colorHex;
  bool? isDisabled;
  String? status;
  String? title;

  BookingStatusData({this.colorHex, this.isDisabled, this.status, this.title});

  factory BookingStatusData.fromJson(Map<String, dynamic> json) {
    return BookingStatusData(
      colorHex: json['color_hex'],
      isDisabled: json['is_disabled'],
      status: json['status'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_hex'] = this.colorHex;
    data['is_disabled'] = this.isDisabled;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}
