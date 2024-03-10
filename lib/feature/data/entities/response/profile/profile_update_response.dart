class ProfileUpdateResponse {
  String? message;
  Data? data;

  ProfileUpdateResponse({this.message, this.data});

  ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? name;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? avatarUrl;

  Data(
      {this.username,
      this.name,
      this.dateOfBirth,
      this.email,
      this.phoneNumber,
      this.avatarUrl});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
