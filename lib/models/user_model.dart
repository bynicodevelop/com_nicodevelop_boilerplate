import "package:equatable/equatable.dart";

class UserModel extends Equatable {
  final String uid;
  final String email;

  const UserModel({
    required this.uid,
    required this.email,
  });

  static UserModel empty() => const UserModel(
        uid: "",
        email: "",
      );

  bool isEmpty() => this == UserModel.empty();

  UserModel copyWith({
    String? uid,
    String? email,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
      );

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data["uid"],
        email: data["email"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
      };

  @override
  List<Object> get props => [
        uid,
        email,
      ];
}
