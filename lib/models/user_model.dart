import "package:equatable/equatable.dart";

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String password;
  final String photoURL;

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL = "",
    this.password = "",
  });

  static UserModel empty() => const UserModel(
        uid: "",
        email: "",
        displayName: "",
        photoURL: "",
        password: "",
      );

  bool isEmpty() => this == UserModel.empty();

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? password,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        photoURL: photoURL ?? this.photoURL,
        password: password ?? this.password,
      );

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data["uid"],
        email: data["email"],
        displayName: data["displayName"],
        photoURL: data["photoURL"],
        password: data["password"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "photoURL": photoURL,
        "password": password,
      };

  @override
  List<Object> get props => [
        uid,
        email,
        displayName,
        photoURL,
        password,
      ];
}
