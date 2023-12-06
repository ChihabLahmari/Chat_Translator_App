import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthentication {
  Future<String> loginWithEmailAndPassword(String email, String password);
  Future<String> registerWithEmailAndPassword(String email, String password);
}

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationImpl(this._firebaseAuth);
  @override
  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Success registerWithEmailAndPassword");
      return credential.user!.uid;
    } on FirebaseException catch (exception) {
      print("🛑 Error registerWithEmailAndPassword");
      print(exception.message);
      rethrow;
    }
  }

  @override
  Future<String> loginWithEmailAndPassword(String email, String password) async {
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Success loginWithEmailAndPassword");
      return credential.user!.uid;
    } on FirebaseAuthException catch (exception) {
      print("🛑 Error loginWithEmailAndPassword");
      print(exception.message);
      rethrow;
    }
  }
}
