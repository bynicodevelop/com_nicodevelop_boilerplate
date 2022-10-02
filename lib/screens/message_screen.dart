import "package:com_nicodevelop_dotmessenger/components/messages/list/list_message_component.dart";
import "package:com_nicodevelop_dotmessenger/models/item_discussion_model.dart";
import "package:flutter/material.dart";

class MessageScreen extends StatelessWidget {
  final ItemDiscussionModel itemDiscussionModel;

  const MessageScreen({
    super.key,
    required this.itemDiscussionModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dot Messenger"),
        actions: const [],
      ),
      body: ListMessageComponent(
        itemDiscussionModel: itemDiscussionModel,
      ),
    );
  }
}
