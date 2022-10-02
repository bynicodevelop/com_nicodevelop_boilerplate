import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/affiliate_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/affiliate_repository.dart";
import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    firebaseFirestore = FakeFirebaseFirestore();
  });

  group("get", () {
    test("Should return user profile", () async {
      // arrange
      await firebaseFirestore.collection("affiliates").doc("0001").set({
        "userId": "123456",
      });

      final AffiliateRepository affiliateRepository = AffiliateRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      // act
      final AffiliateModel affiliateModel = await affiliateRepository.get({
        "affiliateCode": "0001",
      });

      // assert
      expect(affiliateModel.code, "0001");
      expect(affiliateModel.userId, "123456");
    });

    test("Should exepect an exception when code not exists", () async {
      // arrange
      final AffiliateRepository affiliateRepository = AffiliateRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      // act
      // assert
      expect(
        () async {
          await affiliateRepository.get({
            "affiliateCode": "0001",
          });
        },
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "AFFILIATE_NOT_FOUND",
          ),
        ),
      );
    });
  });

  group("getAffiliateCodeByUserId", () {
    test("Should return code", () async {
      // ARRANGE
      firebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: "123456",
        ),
      );

      await firebaseFirestore.collection("affiliates").doc("0001").set({
        "userId": "123456",
      });

      final AffiliateRepository affiliateRepository = AffiliateRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      // ACT
      final String code = await affiliateRepository.getAffiliateCodeByUserId();

      // ASSERT
      expect(code, "0001");
    });

    test("Should expect an unauthenticated error when user is logout",
        () async {
      // ARRANGE
      firebaseAuth = MockFirebaseAuth(
        signedIn: false,
      );

      final AffiliateRepository affiliateRepository = AffiliateRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () async {
          await affiliateRepository.getAffiliateCodeByUserId();
        },
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "USER_NOT_FOUND",
          ),
        ),
      );
    });

    test("Should expect an exception with AFFILIATE_NOT_FOUND", () async {
      // ARRANGE
      firebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: "123456",
        ),
      );

      final AffiliateRepository affiliateRepository = AffiliateRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () async {
          await affiliateRepository.getAffiliateCodeByUserId();
        },
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "AFFILIATE_NOT_FOUND",
          ),
        ),
      );
    });
  });
}
