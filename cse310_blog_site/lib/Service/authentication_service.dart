import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  AuthenticationService({
    this.firebaseAuth,
  });

  Future<String> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(FirebaseAuth.instance.currentUser.uid).set({
        'premium': false,
        'email': email,
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Stream<User> get authStateChanges => firebaseAuth.idTokenChanges();
}
