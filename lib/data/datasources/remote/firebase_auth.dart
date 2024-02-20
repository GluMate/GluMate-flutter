import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // Get the current user after signing in
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      // Create a new document for the user in the users collection
      await _fireStore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
      });
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
