import "package:firebase_auth/firebase_auth.dart";

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  const AuthenticationRepository({
    required this.firebaseAuth,
  });

  Future<void> login(Map<String, dynamic> data) async {}
}
