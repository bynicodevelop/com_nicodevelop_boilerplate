import "package:cloud_firestore/cloud_firestore.dart";
import "package:equatable/equatable.dart";

class ItemDiscussionModel extends Equatable {
  final String id;
  final String lastMessage;
  final DocumentReference from;
  final DateTime lastMessageDate;

  const ItemDiscussionModel({
    required this.id,
    required this.lastMessage,
    required this.from,
    required this.lastMessageDate,
  });

  factory ItemDiscussionModel.fromMap(Map<String, dynamic> map) {
    return ItemDiscussionModel(
      id: map["id"],
      lastMessage: map["lastMessage"],
      from: map["from"],
      lastMessageDate: map["lastMessageDate"].toDate(),
    );
  }

  @override
  List<Object> get props => [
        id,
        lastMessage,
        from,
        lastMessageDate,
      ];
}
