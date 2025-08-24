import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/auth/user.dart';
import '../../domain/core/failures.dart';
import '../../domain/core/value_objects.dart';
import 'firebase_auth_datasource.dart';
import 'user_dto.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuthDataSource _ds;
  FirebaseAuthRepository(FirebaseAuthDataSource ds) : _ds = ds;

  @override
  Future<User> login(
      {required EmailAddress email, required Password password}) async {
    try {
      final (fb.User u, String? token) =
          await _ds.signIn(email.value, password.value);
      final profile = await _ds.userDoc(u.uid);
      final dto = UserDto.fromFirebaseUser(u,
          name: profile?['name'] as String?, token: token);
      return dto.toDomain();
    } on fb.FirebaseAuthException catch (e) {
      throw Failure(e.message ?? 'Login failed', code: e.code.hashCode);
    } catch (e) {
      throw Failure('Login failed: $e');
    }
  }

  @override
  Future<User> signUp({
    required NonEmptyString fullName,
    required EmailAddress email,
    required PhoneNumber phone,
    required Password password,
  }) async {
    try {
      final (fb.User u, String? token) = await _ds.signUp(
        name: fullName.value,
        email: email.value,
        phone: phone.value,
        password: password.value,
      );
      final dto =
          UserDto.fromFirebaseUser(u, name: fullName.value, token: token);
      return dto.toDomain();
    } on fb.FirebaseAuthException catch (e) {
      throw Failure(e.message ?? 'Signup failed', code: e.code.hashCode);
    } catch (e) {
      throw Failure('Signup failed: $e');
    }
  }

  @override
  Future<User> completeProfile(
      {required Age age,
      required Gender gender,
      required WeightKg weight}) async {
    try {
      final u = await _ds.currentUser();
      if (u == null) throw Failure('Not authenticated');
      await _ds.completeProfile(
          uid: u.uid,
          age: age.value,
          gender: gender.value,
          weight: weight.value);
      final token = await _ds.currentToken();
      final dto = UserDto.fromFirebaseUser(u, token: token);
      return dto.toDomain();
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Profile update failed: $e');
    }
  }

  @override
  Future<User?> currentUser() async {
    final u = await _ds.currentUser();
    if (u == null) return null;
    final profile = await _ds.userDoc(u.uid);
    final token = await _ds.currentToken();
    return UserDto.fromFirebaseUser(u,
            name: profile?['name'] as String?, token: token)
        .toDomain();
  }

  @override
  Future<void> logout() => _ds.signOut();
}
