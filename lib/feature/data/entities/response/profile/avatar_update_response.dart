class AvatarUpdateResponse {
  String? message;
  Data? data;

  AvatarUpdateResponse({this.message, this.data});

  AvatarUpdateResponse.fromJson(Map<String, dynamic> json) {
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
  String? avatarUrl;

  Data({this.avatarUrl});

  Data.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
