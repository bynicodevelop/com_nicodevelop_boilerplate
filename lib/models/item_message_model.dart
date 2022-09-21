import 'package:equatable/equatable.dart';

class ItemMessageModel extends Equatable {
  final String id;
  final String message;
  final String sender;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ItemMessageModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        message,
        sender,
        createdAt,
        updatedAt,
      ];
}
