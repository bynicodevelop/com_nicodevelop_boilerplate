import 'dart:async';

import 'package:com_nicodevelop_dotmessenger/models/item_message_model.dart';

class MessagesRepository {
  final StreamController<List<ItemMessageModel>> _messagesController =
      StreamController<List<ItemMessageModel>>.broadcast();

  Stream<List<ItemMessageModel>> get messagesStream =>
      _messagesController.stream;

  Future<void> get() async {}

  Future<void> list() async {
    _messagesController.add([
      ItemMessageModel(
        id: '1',
        message:
            "Incididunt proident id proident excepteur aliqua sint minim voluptate laborum mollit veniam sit duis cillum.",
        sender: "John",
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 1),
      ),
      ItemMessageModel(
        id: '2',
        message: "Eiusmod velit est non pariatur anim duis ipsum.",
        sender: "Jane",
        createdAt: DateTime(2021, 1, 1),
        updatedAt: DateTime(2021, 1, 1),
      ),
    ]);
  }

  Future<void> create(Map<String, dynamic> data) async {}

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
