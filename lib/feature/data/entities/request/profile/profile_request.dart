class ProfileRequest {
  String? email;
  String? name;
  String? dateOfBirth;
  String? phoneNumber;

  ProfileRequest({this.email, this.name, this.dateOfBirth, this.phoneNumber});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
