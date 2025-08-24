class User {
  final String id;
  final String name;
  final String email;
  final String? token;

  const User(
      {required this.id, required this.name, required this.email, this.token});

  User copyWith({String? id, String? name, String? email, String? token}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        token: token ?? this.token,
      );
}
