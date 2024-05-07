import 'package:firebase_auth/firebase_auth.dart';

String? getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String uid = user.uid;
    print('Current User ID: $uid');
    return uid;
  } else {
    print('User not logged in');
    return null;
  }
}
