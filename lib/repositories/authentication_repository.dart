import "dart:async";

import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  AuthenticationRepository({
    required this.firebaseAuth,
  });

  Stream<UserModel> get user => firebaseAuth.authStateChanges().map(
        (User? user) {
          UserModel userModel = UserModel.empty();

          if (user != null) {
            userModel = userModel.copyWith(
              uid: user.uid,
              email: user.email,
              photoURL: user.photoURL ?? "",
            );
          }

          return userModel;
        },
      );

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

  Future<void> logout() async {
    info(
      "$runtimeType - Logging out",
    );

    await firebaseAuth.signOut();
  }

  Future<UserModel> refresh() async {
    info("$runtimeType - Refreshing user model");
    return await user.first;
  }
}
