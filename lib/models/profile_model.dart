import "package:equatable/equatable.dart";

class ProfileModel extends Equatable {
  final String id;
  final String displayName;
  final String photoURL;

  const ProfileModel({
    required this.id,
    required this.displayName,
    required this.photoURL,
  });

  @override
  List<Object?> get props => [
        id,
        displayName,
        photoURL,
      ];

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        id: map["id"],
        displayName: map["displayName"],
        photoURL: map["photoURL"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "displayName": displayName,
        "photoURL": photoURL,
      };

  @override
  String toString() =>
      "ProfileModel(id: $id, displayName: $displayName, photoURL: $photoURL)";
}
