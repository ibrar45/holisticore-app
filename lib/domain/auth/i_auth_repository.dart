import '../core/failures.dart';
import '../core/value_objects.dart';
import 'user.dart';

abstract class IAuthRepository {
  /// returns User or throws Failure
  Future<User> login({required EmailAddress email, required Password password});

  Future<User> signUp({
    required NonEmptyString fullName,
    required EmailAddress email,
    required PhoneNumber phone,
    required Password password,
  });

  Future<User> completeProfile({
    required Age age,
    required Gender gender,
    required WeightKg weight,
  });

  Future<User?> currentUser();
  Future<void> logout();
}
