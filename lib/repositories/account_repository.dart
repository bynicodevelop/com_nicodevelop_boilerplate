import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_boilerplate/exceptions/standard_exception.dart";
import "package:com_nicodevelop_boilerplate/utils/logger.dart";
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
    assert(data["displayName"] != null);
    assert(data["email"] != null);
    assert(data["password"] != null);

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
        "displayName": data["displayName"],
      };

      userCredential.user!.updateDisplayName(data["displayName"]);

      if (userAccount.exists) {
        await userAccount.reference.update(accountData);

        info(
          "$runtimeType - Account updated",
          data: accountData,
        );

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

  Future<void> _updateFirestoreUserProfile(Map<String, dynamic> data) async {
    assert(data["uid"] != null);

    info(
      "$runtimeType - Updating Firestore user profile",
      data: data,
    );

    final DocumentReference<Map<String, dynamic>> userReference =
        firebaseFirestore.collection("users").doc(data["uid"]);

    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await userReference.get();

    data.remove("uid");

    if (!userSnapshot.exists) {
      await userReference.set(data);

      return;
    }

    await userReference.update(data);
  }

  Future<void> update(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "unauthenticated",
      );
    }

    info(
      "$runtimeType - Updating account",
      data: data,
    );

    try {
      final Map<String, dynamic> accountData = {};

      if (data["email"] != user.email) {
        info("$runtimeType - Updating email");
        await user.updateEmail(data["email"]);
      }

      if (data["displayName"] != user.displayName) {
        info("$runtimeType - Updating display name");
        await user.updateDisplayName(data["displayName"]);

        accountData["displayName"] = data["displayName"];
      }

      if ((data["password"] ?? "").isNotEmpty) {
        info("$runtimeType - Updating password");
        await user.updatePassword(data["password"]);
      }

      if (data["photoURL"] != null) {
        info("$runtimeType - Updating photoURL");
        await user.updatePhotoURL(data["photoURL"]);

        accountData["photoURL"] = data["photoURL"];
      }

      if (accountData.isNotEmpty) {
        await _updateFirestoreUserProfile({
          "uid": user.uid,
          ...accountData,
        });
      }

      info(
        "$runtimeType - Account updated",
        data: data,
      );
    } on FirebaseAuthException catch (e) {
      const String message = "Failed to update account";
      String code = "unknown";

      error(e.message ?? message, data: {
        "code": e.code,
      });

      [
        "email-already-in-use",
        "invalid-email",
        "operation-not-allowed",
        "weak-password",
        "network-request-failed",
      ].contains(e.code)
          ? code = e.code
          : code;

      throw StandardException(
        message,
        code,
      );
    }
  }

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "unauthenticated",
      );
    }

    info(
      "$runtimeType - Deleting account",
    );

    try {
      await user.delete();

      await firebaseAuth.signOut();

      info(
        "$runtimeType - Account deleted",
      );
    } on FirebaseAuthException catch (e) {
      const String message = "Failed to delete account";
      String code = "unknown";

      error(e.message ?? message, data: {
        "code": e.code,
      });

      [
        "requires-recent-login",
        "network-request-failed",
      ].contains(e.code)
          ? code = e.code
          : code;

      throw StandardException(
        message,
        code,
      );
    }
  }
}
