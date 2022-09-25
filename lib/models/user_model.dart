import "package:equatable/equatable.dart";

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String password;

  const UserModel({
    required this.uid,
    required this.email,
    this.password = "",
  });

  static UserModel empty() => const UserModel(
        uid: "",
        email: "",
        password: "",
      );

  bool isEmpty() => this == UserModel.empty();

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data["uid"],
        email: data["email"],
        password: data["password"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "password": password,
      };

  @override
  List<Object> get props => [
        uid,
        email,
        password,
      ];
}
