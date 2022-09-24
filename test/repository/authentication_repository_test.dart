import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/authentication_repository.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AuthenticationRepository", () {
    late AuthenticationRepository authenticationRepository;
    late MockFirebaseAuth mockFirebaseAuth;

    test("Should be able to login with success", () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth();

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      await authenticationRepository.login({
        "email": "john@domain.tld",
        "password": "password",
      });

      // ASSERT
      expect(
        mockFirebaseAuth.currentUser,
        isNotNull,
      );
    });

    test("Should be expect bad credential authentication (email not found)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: FirebaseAuthException(
            code: "user-not-found",
          ),
        ),
      );

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () => authenticationRepository.login({
          "email": "john@domain.tld",
          "password": "123456",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "user-not-found",
          ),
        ),
      );
    });

    test("Should be expect bad credential authentication (wrong password)",
        () async {
      // ARRANGE
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: FirebaseAuthException(
            code: "wrong-password",
          ),
        ),
      );

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () => authenticationRepository.login({
          "email": "john@domain.tld",
          "password": "123456",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "wrong-password",
          ),
        ),
      );
    });
  });
}
