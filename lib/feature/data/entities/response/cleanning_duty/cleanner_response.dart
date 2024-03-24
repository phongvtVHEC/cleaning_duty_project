class Cleaner {
  int? id;
  String? email;

  Cleaner({this.id, this.email});

  Cleaner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    return data;
  }

  @override
  String toString() {
    return 'Cleaner { id: $id, email: $email }';
  }
}
