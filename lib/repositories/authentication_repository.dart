import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  const AuthenticationRepository({
    required this.firebaseAuth,
  });

  Future<void> login(Map<String, dynamic> data) async {
    assert(data["email"] != null);
    assert(data["password"] != null);

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: data["email"],
        password: data["password"],
      );
    } on FirebaseAuthException catch (e) {
      throw StandardException(
        e.message ?? "Authentication error",
        e.code,
      );
    }
  }
}
