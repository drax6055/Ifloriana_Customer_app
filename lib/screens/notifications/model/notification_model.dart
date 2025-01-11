class NotificationListResponse {
  int? allUnreadCount;
  String? message;
  List<NotificationData>? notificationData;
  bool? status;

  NotificationListResponse({this.allUnreadCount, this.message, this.notificationData, this.status});

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      allUnreadCount: json['all_unread_count'],
      message: json['message'],
      notificationData: json['notification_data'] != null ? (json['notification_data'] as List).map((i) => NotificationData.fromJson(i)).toList() : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_unread_count'] = this.allUnreadCount;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.notificationData != null) {
      data['notification_data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  NotificationModel? data;
  String? createdAt;
  String? id;
  int? notifiableId;
  String? notifiableType;
  String? readAt;
  String? type;
  String? updatedAt;

  NotificationData({this.data, this.createdAt, this.id, this.notifiableId, this.notifiableType, this.readAt, this.type, this.updatedAt});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      data: json['data'] != null ? NotificationModel.fromJson(json['data']) : null,
      createdAt: json['created_at'],
      id: json['id'],
      notifiableId: json['notifiable_id'],
      notifiableType: json['notifiable_type'],
      readAt: json['read_at'] != null ? json['read_at'] : null,
      type: json['type'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['notifiable_id'] = this.notifiableId;
    data['notifiable_type'] = this.notifiableType;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.readAt != null) {
      data['read_at'] = this.readAt;
    }
    return data;
  }
}

class NotificationModel {
  NotificationDetail? notificationDetail;
  String? subject;

  NotificationModel({this.notificationDetail, this.subject});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationDetail: json['data'] != null ? NotificationDetail.fromJson(json['data']) : null,
      subject: json['subject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    if (this.notificationDetail != null) {
      data['data'] = this.notificationDetail!.toJson();
    }
    return data;
  }
}

class NotificationDetail {
  String? bookingDate;
  String? orderDate;
  int? bookingDuration;
  String? bookingServicesNames;
  String? bookingTime;
  String? orderTime;
  String? companyContactInfo;
  String? companyName;
  String? description;
  int? employeeId;
  String? employeeName;
  int? id;
  String? loggedInUserFullName;
  String? loggedInUserRole;
  String? notificationGroup;
  String? notificationType;
  String? siteUrl;
  String? type;
  int? userId;
  String? userName;
  String? venueAddress;
  String? orderCode;

  NotificationDetail({
    this.bookingDate,
    this.orderDate,
    this.bookingDuration,
    this.bookingServicesNames,
    this.bookingTime,
    this.orderTime,
    this.companyContactInfo,
    this.companyName,
    this.description,
    this.employeeId,
    this.employeeName,
    this.id,
    this.loggedInUserFullName,
    this.loggedInUserRole,
    this.notificationGroup,
    this.notificationType,
    this.siteUrl,
    this.type,
    this.userId,
    this.userName,
    this.venueAddress,
    this.orderCode,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      bookingDate: json['booking_date'],
      orderDate: json['order_date'],
      bookingDuration: json['booking_duration'],
      bookingServicesNames: json['booking_services_names'],
      bookingTime: json['booking_time'],
      orderTime: json['order_time'],
      companyContactInfo: json['company_contact_info'],
      companyName: json['company_name'],
      description: json['description'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      id: json['id'],
      loggedInUserFullName: json['logged_in_user_fullname'],
      loggedInUserRole: json['logged_in_user_role'],
      notificationGroup: json['notification_group'],
      notificationType: json['notification_type'],
      siteUrl: json['site_url'],
      type: json['type'],
      userId: json['user_id'],
      userName: json['user_name'],
      venueAddress: json['venue_address'],
      orderCode: json['order_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_date'] = this.bookingDate;
    data['order_date'] = this.orderDate;
    data['booking_duration'] = this.bookingDuration;
    data['booking_services_names'] = this.bookingServicesNames;
    data['booking_time'] = this.bookingTime;
    data['order_time'] = this.orderTime;
    data['company_contact_info'] = this.companyContactInfo;
    data['company_name'] = this.companyName;
    data['description'] = this.description;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['id'] = this.id;
    data['logged_in_user_fullname'] = this.loggedInUserFullName;
    data['logged_in_user_role'] = this.loggedInUserRole;
    data['notification_group'] = this.notificationGroup;
    data['notification_type'] = this.notificationType;
    data['site_url'] = this.siteUrl;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['venue_address'] = this.venueAddress;
    data['order_code'] = this.orderCode;
    return data;
  }
}
