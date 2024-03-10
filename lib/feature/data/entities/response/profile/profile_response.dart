class ProfileResponse {
  int? id;
  String? username;
  String? name;
  String? dateOfBirth;
  String? email;
  String? avatarUrl;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;

  ProfileResponse(
      {this.id,
      this.username,
      this.name,
      this.dateOfBirth,
      this.email,
      this.phoneNumber,
      this.avatarUrl,
      this.createdAt,
      this.updatedAt});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatarUrl = json['avatar_url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['avatar_url'] = avatarUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
