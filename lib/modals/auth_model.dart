class MyUser {
  static const String collectionName = 'users';
  String id;
  String name;
  String email;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  MyUser.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          email: json['email'] as String,
        );
}
