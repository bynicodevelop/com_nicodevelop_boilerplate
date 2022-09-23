import "package:equatable/equatable.dart";

class ProfileModel extends Equatable {
  final String userId;
  final String code;

  const ProfileModel({
    required this.userId,
    required this.code,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
        userId: data["userId"],
        code: data["code"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "code": code,
      };

  @override
  List<Object?> get props => [
        userId,
        code,
      ];
}
