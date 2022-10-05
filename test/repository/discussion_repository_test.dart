import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_boilerplate/models/item_discussion_model.dart";
import "package:com_nicodevelop_boilerplate/repositories/discussion_repository.dart";
import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  late DiscussionRepository discussionRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late FakeFirebaseFirestore mockFirebaseFirestore;

  setUp(() {
    mockFirebaseFirestore = FakeFirebaseFirestore();
  });

  group("list", () {
    test("Doit retourner une liste de discussions", () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: "123456789",
        ),
      );

      final DocumentReference documentReference =
          mockFirebaseFirestore.collection("users").doc("123456789");

      mockFirebaseFirestore.collection("users").doc("000000001").set({
        "uid": "000000001",
        "displayName": "John Doe",
        "photoURL": "https://www.google.com",
      });

      mockFirebaseFirestore.collection("users").doc("987654321").set({
        "uid": "987654321",
        "displayName": "Jane Doe",
        "photoURL": "https://www.google.com",
      });

      mockFirebaseFirestore
          .collection("discussions")
          .doc("123456789_987654321")
          .set({
        "from": documentReference,
        "lastMessage": "Hello",
        "lastMessageDate": DateTime.now().subtract(
          const Duration(
            minutes: 1,
          ),
        ),
        "uid": "123456789_987654321",
        "users": ["123456789", "987654321"],
      });

      mockFirebaseFirestore
          .collection("discussions")
          .doc("123456789_000000001")
          .set({
        "from": documentReference,
        "lastMessage": "Hello",
        "lastMessageDate": DateTime.now(),
        "uid": "123456789_000000001",
        "users": ["123456789", "000000001"],
      });

      discussionRepository = DiscussionRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      await discussionRepository.list();

      // ASSERT
      List<ItemDiscussionModel> itemDiscussionModels =
          await discussionRepository.discussions.first;

      expect(
        itemDiscussionModels.length,
        2,
      );

      expect(
        itemDiscussionModels.first.id,
        "123456789_000000001",
      );

      expect(
        itemDiscussionModels.first.from.displayName,
        "John Doe",
      );

      expect(itemDiscussionModels[0].id, "123456789_000000001");
      expect(itemDiscussionModels[1].id, "123456789_987654321");
    });

    test("Doit retourner une liste de discussions vide", () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: "123456789",
        ),
      );

      discussionRepository = DiscussionRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      await discussionRepository.list();

      // ASSERT
      List<ItemDiscussionModel> itemDiscussionModels =
          await discussionRepository.discussions.first;

      expect(
        itemDiscussionModels.length,
        0,
      );
    });
  });
}
