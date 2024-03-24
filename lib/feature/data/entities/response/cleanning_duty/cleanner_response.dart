class Cleaner {
  int? id;
  String? email;
  String? avatarUrl;

  Cleaner({this.id, this.email, this.avatarUrl});

  Cleaner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['avatar_url'] = avatarUrl;
    return data;
  }

  @override
  String toString() {
    return 'Cleaner { id: $id, email: $email, avatarUrl: $avatarUrl}';
  }
}
