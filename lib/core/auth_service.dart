import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final _authInstance = FirebaseAuth.instance;

  login(String email, String senha) async {
    try {
      UserCredential usuario = await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (ex) {
      print(ex);
    }
  }
}
