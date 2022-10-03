import "package:com_nicodevelop_dotmessenger/models/profile_model.dart";
import "package:equatable/equatable.dart";

class ItemMessageModel extends Equatable {
  final String id;
  final String message;
  final ProfileModel from;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ItemMessageModel({
    required this.id,
    required this.message,
    required this.from,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemMessageModel.fromJson(Map<String, dynamic> json) =>
      ItemMessageModel(
        id: json["id"],
        message: json["message"],
        from: json["from"],
        createdAt: json["createdAt"].toDate(),
        updatedAt: json["updatedAt"].toDate(),
      );

  @override
  List<Object?> get props => [
        id,
        message,
        from,
        createdAt,
        updatedAt,
      ];
}
