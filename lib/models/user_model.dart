import "package:equatable/equatable.dart";

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String password;
  final String photoUrl;

  const UserModel({
    required this.uid,
    required this.email,
    this.photoUrl = "",
    this.password = "",
  });

  static UserModel empty() => const UserModel(
        uid: "",
        email: "",
        photoUrl: "",
        password: "",
      );

  bool isEmpty() => this == UserModel.empty();

  UserModel copyWith({
    String? uid,
    String? email,
    String? photoUrl,
    String? password,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        password: password ?? this.password,
      );

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data["uid"],
        email: data["email"],
        photoUrl: data["photoUrl"],
        password: data["password"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "password": password,
      };

  @override
  List<Object> get props => [
        uid,
        email,
        photoUrl,
        password,
      ];
}
