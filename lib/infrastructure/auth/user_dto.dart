import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/auth/user.dart';

class UserDto {
  final String id;
  final String name;
  final String email;
  final String? token;

  UserDto(
      {required this.id, required this.name, required this.email, this.token});

  factory UserDto.fromFirebaseUser(fb.User u, {String? name, String? token}) {
    return UserDto(
      id: u.uid,
      name: name ?? (u.displayName ?? ''),
      email: u.email ?? '',
      token: token,
    );
  }

  User toDomain() => User(id: id, name: name, email: email, token: token);
}
