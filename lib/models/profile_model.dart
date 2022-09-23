import "package:equatable/equatable.dart";

class ProfileModel extends Equatable {
  final String uid;
  final String code;

  const ProfileModel({
    required this.uid,
    required this.code,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
        uid: data["uid"],
        code: data["code"],
      );

  @override
  List<Object?> get props => [];
}
