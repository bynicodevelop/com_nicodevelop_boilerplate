import "package:equatable/equatable.dart";

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String password;
  final String photoURL;

  const UserModel({
    required this.uid,
    required this.email,
    this.photoURL = "",
    this.password = "",
  });

  static UserModel empty() => const UserModel(
        uid: "",
        email: "",
        photoURL: "",
        password: "",
      );

  bool isEmpty() => this == UserModel.empty();

  UserModel copyWith({
    String? uid,
    String? email,
    String? photoURL,
    String? password,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        photoURL: photoURL ?? this.photoURL,
        password: password ?? this.password,
      );

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data["uid"],
        email: data["email"],
        photoURL: data["photoURL"],
        password: data["password"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "photoURL": photoURL,
        "password": password,
      };

  @override
  List<Object> get props => [
        uid,
        email,
        photoURL,
        password,
      ];
}
