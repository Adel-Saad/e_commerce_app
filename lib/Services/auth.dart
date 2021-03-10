import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
// prop ..
  final _auth = FirebaseAuth.instance;

// Sign up ...
  Future<bool> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return true;
  }

// sign in ...
  Future<UserCredential> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

// logout ...

  Future<void> signOut() async {
    await _auth.signOut();
  }

// info

}
