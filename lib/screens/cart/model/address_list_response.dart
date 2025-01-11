class AddressListResponse {
  String? message;
  List<UserAddress>? userAddress;
  bool? status;

  AddressListResponse({
    this.message,
    this.userAddress,
    this.status,
  });

  factory AddressListResponse.fromJson(Map<String, dynamic> json) => AddressListResponse(
        message: json["message"],
        userAddress: json["data"] == null ? [] : List<UserAddress>.from(json["data"]!.map((x) => UserAddress.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": userAddress == null ? [] : List<dynamic>.from(userAddress!.map((x) => x.toJson())),
        "status": status,
      };
}

class UserAddress {
  int? id;
  String? addressLine1;
  String? addressLine2;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? cityName;
  String? stateName;
  String? countryName;
  int? latitude;
  int? longitude;
  int? isPrimary;
  int? addressableId;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? firstName;
  String? lastName;

  UserAddress({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.cityName,
    this.stateName,
    this.countryName,
    this.latitude,
    this.longitude,
    this.isPrimary,
    this.addressableId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.firstName,
    this.lastName,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        postalCode: json["postal_code"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        cityName: json["city_name"],
        stateName: json["state_name"],
        countryName: json["country_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isPrimary: json["is_primary"],
        addressableId: json["addressable_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "postal_code": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "city_name": cityName,
        "state_name": stateName,
        "country_name": countryName,
        "latitude": latitude,
        "longitude": longitude,
        "is_primary": isPrimary,
        "addressable_id": addressableId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "first_name": firstName,
        "last_name": lastName,
      };
}
