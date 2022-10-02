import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/profile_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/item_message_model.dart";
import "package:firebase_auth/firebase_auth.dart";

class MessageRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  MessageRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final StreamController<List<ItemMessageModel>> _streamController =
      StreamController.broadcast();

  Stream<List<ItemMessageModel>> get messages => _streamController.stream;

  Future<void> get() async {}

  Future<void> list(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "unauthenticated",
      );
    }

    List<ItemMessageModel> messages = [];

    Stream<QuerySnapshot<Map<String, dynamic>>> messagesQuerySnapshot =
        firebaseFirestore
            .collection("discussions")
            .doc(data["discussionId"])
            .collection("messages")
            .orderBy(
              "createdAt",
              descending: true,
            )
            .snapshots();

    messagesQuerySnapshot
        .listen((QuerySnapshot<Map<String, dynamic>> event) async {
      messages.clear();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        final Map<String, dynamic> message = doc.data();

        final DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
            await message["from"].get();

        messages.add(
          ItemMessageModel.fromJson({
            ...message,
            "id": doc.id,
            "from": ProfileModel.fromMap({
              "id": userDocumentSnapshot.id,
              ...userDocumentSnapshot.data()!
            }),
          }),
        );
      }

      _streamController.add(messages);
    });
  }

  Future<void> create(Map<String, dynamic> data) async {}

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
