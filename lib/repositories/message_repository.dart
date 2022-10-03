import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
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

  final List<DocumentSnapshot> _documentSnapshot = [];
  final List<ItemMessageModel> _messages = [];

  Future<void> get() async {}

  Future<void> list(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "unauthenticated",
      );
    }

    late Stream<QuerySnapshot<Map<String, dynamic>>> messagesQuerySnapshot;

    if (_documentSnapshot.isEmpty) {
      messagesQuerySnapshot = firebaseFirestore
          .collection("discussions")
          .doc(data["discussionId"])
          .collection("messages")
          .orderBy(
            "createdAt",
            descending: true,
          )
          .limit(kMaxMessageLoad)
          .snapshots();
    } else {
      messagesQuerySnapshot = firebaseFirestore
          .collection("discussions")
          .doc(data["discussionId"])
          .collection("messages")
          .orderBy(
            "createdAt",
            descending: true,
          )
          .limit(kMaxMessageLoad)
          .startAfterDocument(
            _documentSnapshot[_documentSnapshot.length - 1],
          )
          .snapshots();
    }

    messagesQuerySnapshot
        .listen((QuerySnapshot<Map<String, dynamic>> event) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        final Map<String, dynamic> message = doc.data();

        final DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
            await message["from"].get();

        _messages.add(ItemMessageModel.fromJson({
          ...message,
          "id": doc.id,
          "from": ProfileModel.fromMap({
            "id": userDocumentSnapshot.id,
            ...userDocumentSnapshot.data()!,
          }),
        }));

        _documentSnapshot.add(doc);
      }

      _streamController.add(_messages);
    });
  }

  Future<void> create(Map<String, dynamic> data) async {}

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
