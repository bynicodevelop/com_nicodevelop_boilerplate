import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:firebase_auth/firebase_auth.dart";

class DiscussionRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  DiscussionRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final StreamController<List<ItemDiscussionModel>> _streamController =
      StreamController.broadcast();

  Stream<List<ItemDiscussionModel>> get discussions => _streamController.stream;

  Future<void> get() async {}

  Future<void> list() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "unauthenticated",
      );
    }

    List<ItemDiscussionModel> discussions = [];

    Stream<QuerySnapshot<Map<String, dynamic>>> discussionsQuerySnapshot =
        firebaseFirestore
            .collection("discussions")
            .orderBy(
              "lastMessageDate",
              descending: true,
            )
            .where(
              "users",
              arrayContains: user.uid,
            )
            .snapshots();

    discussionsQuerySnapshot
        .listen((QuerySnapshot<Map<String, dynamic>> event) {
      discussions.clear();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        discussions.add(
          ItemDiscussionModel.fromMap({
            "id": doc.id,
            ...doc.data(),
          }),
        );
      }

      _streamController.add(discussions);
    });
  }

  Future<void> create(Map<String, dynamic> data) async {}

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
