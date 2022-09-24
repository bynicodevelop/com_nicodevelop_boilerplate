import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
import "package:firebase_auth/firebase_auth.dart";

class AccountRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  const AccountRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Future<void> get() async {}

  Future<void> list() async {}

  Future<void> create(Map<String, dynamic> data) async {
    assert(data["email"] != null);
    assert(data["password"] != null);
    assert(data["affiliateCode"] != null);

    info(
      "$runtimeType - Creating account",
      data: data,
    );

    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: data["email"],
        password: data["password"],
      );

      DocumentSnapshot<Map<String, dynamic>> userAccount =
          await firebaseFirestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .get();

      final Map<String, dynamic> accountData = {
        "affiliateCodeRef": firebaseFirestore
            .collection("affiliates")
            .doc(data["affiliateCode"]),
        "email": data["email"],
      };

      if (userAccount.exists) {
        await userAccount.reference.update(accountData);

        return;
      }

      await userAccount.reference.set(accountData);
    } on FirebaseAuthException catch (e) {
      const String message = "Failed to create account";
      String code = "unknown";

      [
        "email-already-in-use",
        "invalid-email",
        "operation-not-allowed",
        "weak-password",
      ].contains(e.code)
          ? code = e.code
          : code;

      throw StandardException(
        message,
        code,
      );
    }
  }

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
