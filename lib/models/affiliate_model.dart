import "package:equatable/equatable.dart";

class AffiliateModel extends Equatable {
  final String userId;
  final String code;

  const AffiliateModel({
    required this.userId,
    required this.code,
  });

  factory AffiliateModel.fromMap(Map<String, dynamic> data) => AffiliateModel(
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
