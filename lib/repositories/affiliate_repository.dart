import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/models/profile_model.dart";

class AffiliateRepository {
  final FirebaseFirestore firebaseFirestore;

  const AffiliateRepository({
    required this.firebaseFirestore,
  });

  // Recherche un afflié par son id dans la collection 'affiliates'
  // De Firestore
  Future<ProfileModel> get(Map<String, dynamic> data) async {
    final DocumentReference<Map<String, dynamic>> documentReference =
        firebaseFirestore.collection("affiliates").doc(data["affiliateCode"]);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();

    if (documentSnapshot.exists) {
      return ProfileModel.fromMap({
        "uid": documentSnapshot.id,
        ...documentSnapshot.data()!,
      });
    } else {
      throw Exception("Document does not exist");
    }
  }

  // Future<void> list() async {}

  // Future<void> create(Map<String, dynamic> data) async {}

  // Future<void> update(Map<String, dynamic> data) async {}

  // Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  // Future<void> delete(Map<String, dynamic> data) async {}
}
