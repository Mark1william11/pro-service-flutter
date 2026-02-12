import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../domain/app_user.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().switchMap((user) {
      if (user == null) return Stream.value(null);
      
      return _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
            if (snapshot.exists) {
              return AppUser.fromMap(snapshot.data()!);
            }
            return AppUser(
              id: user.uid,
              email: user.email ?? '',
              name: user.displayName ?? user.email?.split('@')[0] ?? 'User',
            );
          });
    });
  }

  Future<AppUser?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // The stream will emit the user
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> signUpWithEmail(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        
        final appUser = AppUser(
          id: user.uid,
          email: user.email ?? '',
          name: name,
          createdAt: DateTime.now(),
        );
        
        await _firestore.collection('users').doc(user.uid).set(appUser.toMap());
        
        return appUser;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String name,
    String? phoneNumber,
    String? bio,
    String? profileImageUrl,
    bool clearProfileImage = false,
  }) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      final Map<String, dynamic> updateData = {
        'id': user.uid,
        'email': user.email ?? '',
        'name': name,
        'phoneNumber': phoneNumber,
        'bio': bio,
      };

      if (clearProfileImage) {
        updateData['profileImageUrl'] = FieldValue.delete();
      } else if (profileImageUrl != null) {
        updateData['profileImageUrl'] = profileImageUrl;
      }

      await _firestore.collection('users').doc(user.uid).set(
            updateData,
            SetOptions(merge: true),
          );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
