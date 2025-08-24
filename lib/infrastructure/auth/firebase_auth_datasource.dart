import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  FirebaseAuthDataSource(this._auth, this._db);

  Future<(User user, String? token)> signIn(
      String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final token = await cred.user?.getIdToken();
    return (cred.user!, token);
  }

  Future<(User user, String? token)> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await cred.user!.updateDisplayName(name);

    // Create user doc in Firestore (basic profile)
    await _db.collection('users').doc(cred.user!.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final token = await cred.user?.getIdToken();
    return (cred.user!, token);
  }

  Future<void> completeProfile({
    required String uid,
    required int age,
    required String gender,
    required double weight,
  }) async {
    await _db.collection('users').doc(uid).set({
      'age': age,
      'gender': gender,
      'weightKg': weight,
      'profileCompletedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<User?> currentUser() async => _auth.currentUser;

  Future<String?> currentToken() async => _auth.currentUser?.getIdToken();

  Future<Map<String, dynamic>?> userDoc(String uid) async {
    final snap = await _db.collection('users').doc(uid).get();
    return snap.data();
  }

  Future<void> signOut() => _auth.signOut();
}
