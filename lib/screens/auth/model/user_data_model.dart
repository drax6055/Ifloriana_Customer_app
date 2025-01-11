class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  int? status;
  String? email;
  String? socialImage;
  String? mobile;
  String? gender;
  String? uid;
  String? loginType;
  String? displayName;
  String? apiToken;
  String? playerId;
  String? createdAt;
  String? updatedAt;
  List<String>? userRole;
  String? password;
  String? userType;
  String? profileImage;

  UserData({
    this.apiToken,
    this.mobile,
    this.gender,
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.playerId,
    this.socialImage,
    this.uid,
    this.status,
    this.userRole,
    this.displayName,
    this.username,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.userType,
    this.profileImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      apiToken: json['api_token'],
      mobile: json['mobile'],
      gender: json['gender'],
      email: json['email'],
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
      playerId: json['player_id'],
      status: json['status'],
      displayName: json['display_name'],
      uid: json['uid'],
      userRole: json['user_role'] != null ? new List<String>.from(json['user_role']) : null,
      username: json['username'],
      loginType: json['login_type'],
      socialImage: json['social_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      password: json['password'],
      userType: json['user_type'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apiToken != null) data['api_token'] = this.apiToken;
    if (this.mobile != null) data['mobile'] = this.mobile;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.email != null) data['email'] = this.email;
    if (this.firstName != null) data['first_name'] = this.firstName;
    if (this.id != null) data['id'] = this.id;
    if (this.lastName != null) data['last_name'] = this.lastName;
    if (this.playerId != null) data['player_id'] = this.playerId;
    if (this.status != null) data['status'] = this.status;
    if (this.username != null) data['username'] = this.username;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.loginType != null) data['login_type'] = this.loginType;
    if (this.socialImage != null) data['social_image'] = this.socialImage;
    if (this.createdAt != null) data['created_at'] = this.createdAt;
    if (this.updatedAt != null) data['updated_at'] = this.updatedAt;
    if (this.uid != null) data['uid'] = this.uid;
    if (this.password != null) data['password'] = this.password;
    if (this.userType != null) data['user_type'] = this.userType;
    if (this.profileImage != null) data['profile_image'] = this.profileImage;
    if (this.userRole != null) {
      data['user_role'] = this.userRole;
    }
    return data;
  }
}
