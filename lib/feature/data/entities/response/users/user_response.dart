class User {
  int? id;
  String? name;
  String? avatarUrl;

  User({
    this.id,
    this.name,
    this.avatarUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar_url'] = avatarUrl;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, avatarUrl: $avatarUrl}';
  }
}
