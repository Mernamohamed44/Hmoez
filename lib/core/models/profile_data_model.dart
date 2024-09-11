class ProfileDataModel {
  String? result;
  String? message;
  int? status;
  Data? data;

  ProfileDataModel({this.result, this.message, this.status, this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? fullname;
  bool? isActive;
  String? email;
  String? image;
  String? phone;
  String? token;

  User(
      {this.id,
      this.fullname,
      this.isActive,
      this.email,
      this.image,
      this.phone,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fullname = json['fullname'] ?? "";
    isActive = json['is_active'] ?? false;
    email = json['email'] ?? "";
    image = json['image'] ?? "";
    phone = json['phone'] ?? "";
    token = json['token'] ?? "";
  }
}
