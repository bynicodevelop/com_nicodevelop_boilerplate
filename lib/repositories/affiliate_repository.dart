import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_boilerplate/exceptions/standard_exception.dart";
import "package:com_nicodevelop_boilerplate/models/affiliate_model.dart";
import "package:com_nicodevelop_boilerplate/utils/logger.dart";
import "package:firebase_auth/firebase_auth.dart";

class AffiliateRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const AffiliateRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future<AffiliateModel> get(Map<String, dynamic> data) async {
    info(
      "$runtimeType - get",
      data: data,
    );

    try {
      final DocumentReference<Map<String, dynamic>> documentReference =
          firebaseFirestore.collection("affiliates").doc(
                data["affiliateCode"],
              );

      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentReference.get();

      if (documentSnapshot.exists) {
        return AffiliateModel.fromMap({
          "code": documentSnapshot.id,
          ...documentSnapshot.data()!,
        });
      } else {
        throw StandardException(
          "Affiliate not found",
          "AFFILIATE_NOT_FOUND",
        );
      }
    } on FirebaseException catch (e) {
      error(
        "$runtimeType - ${e.code} - ${e.message}",
      );
      throw StandardException(
        e.message ?? "unexpected-error",
        e.code,
      );
    }
  }

  Future<String> getAffiliateCodeByUserId() async {
    info(
      "$runtimeType - getAffiliateCodeByUserId",
    );

    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "USER_NOT_FOUND",
      );
    }

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection("affiliates")
              .where("userId", isEqualTo: user.uid)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        throw StandardException(
          "Affiliate not found",
          "AFFILIATE_NOT_FOUND",
        );
      }
    } on FirebaseException catch (e) {
      error(
        "$runtimeType - ${e.code} - ${e.message}",
      );

      throw Exception(e.message);
    }
  }

  // Future<void> list() async {}

  // Future<void> create(Map<String, dynamic> data) async {}

  // Future<void> update(Map<String, dynamic> data) async {}

  // Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  // Future<void> delete(Map<String, dynamic> data) async {}
}
