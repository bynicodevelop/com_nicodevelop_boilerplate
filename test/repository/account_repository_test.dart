import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/account_repository.dart";
import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AccountRepository", () {
    late AccountRepository accountRepository;
    late MockFirebaseAuth mockFirebaseAuth;
    late FakeFirebaseFirestore mockFirebaseFirestore;

    setUp(() {
      mockFirebaseFirestore = FakeFirebaseFirestore();
    });

    test("Should be able to register with success", () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth();

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      await accountRepository.create({
        "email": "john@domain.tld",
        "password": "password",
        "affiliateCode": "0001",
      });

      // ASSERT
      expect(
        mockFirebaseAuth.currentUser,
        isNotNull,
      );
    });

    test(
        "Should be expect bad credential authentication (email already in use)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword: FirebaseAuthException(
            code: "email-already-in-use",
          ),
        ),
      );

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () => accountRepository.create({
          "email": "john@domain.tld",
          "password": "123456",
          "affiliateCode": "0001",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "email-already-in-use",
          ),
        ),
      );
    });

    test("Should be expect bad credential authentication (invalid-email)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword: FirebaseAuthException(
            code: "invalid-email",
          ),
        ),
      );

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () => accountRepository.create({
          "email": "john@domain.tld",
          "password": "123456",
          "affiliateCode": "0001",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "invalid-email",
          ),
        ),
      );
    });

    test("Should be expect bad credential authentication (weak-password)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword: FirebaseAuthException(
            code: "weak-password",
          ),
        ),
      );

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () => accountRepository.create({
          "email": "john@domain.tld",
          "password": "123",
          "affiliateCode": "0001",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "weak-password",
          ),
        ),
      );
    });
  });

  group("Update", () {
    late AccountRepository accountRepository;
    late MockFirebaseAuth mockFirebaseAuth;
    late FakeFirebaseFirestore mockFirebaseFirestore;

    test("Should update email with success", () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          email: "john@domain.tld",
        ),
      );
      mockFirebaseFirestore = FakeFirebaseFirestore();

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      await accountRepository.update({
        "email": "johnny@domain.tld",
      });

      // ASSERT
      expect(
        mockFirebaseAuth.currentUser,
        isNotNull,
      );

      expect(
        mockFirebaseAuth.currentUser!.email,
        "johnny@domain.tld",
      );
    });

    test("should expect StandardException exception (unauthenticated)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        signedIn: false,
      );

      mockFirebaseFirestore = FakeFirebaseFirestore();

      accountRepository = AccountRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      // ACT
      // ASSERT
      expect(
        () async => await accountRepository.update({
          "email": "john@domain.tld",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "unauthenticated",
          ),
        ),
      );
    });
  });
}
