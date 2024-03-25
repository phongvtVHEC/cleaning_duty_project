import 'package:cleaning_duty_project/feature/data/entities/response/users/user_response.dart';

class UserResponse {
  String? message;
  Data? data;

  UserResponse({this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<User>? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['User'] != null) {
      user = <User>[];
      json['User'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['User'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
