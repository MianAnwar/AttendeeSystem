import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // login with Email and Pin Code
  Future sigIn(String e, String p) async {
    try {
      UserCredential res =
          await _auth.signInWithEmailAndPassword(email: e, password: p);

      return res;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return -1;
      } else if (e.code == "wrong-password") {
        return -2;
      }
      return null;
    }
  }

  // logout
  Future sigout() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
