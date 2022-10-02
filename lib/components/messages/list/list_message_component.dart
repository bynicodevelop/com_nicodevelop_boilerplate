import "package:com_nicodevelop_dotmessenger/models/item_discussion_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/services/list_message/list_message_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListMessageComponent extends StatelessWidget {
  final ItemDiscussionModel itemDiscussionModel;

  const ListMessageComponent({
    Key? key,
    required this.itemDiscussionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMessageBloc, ListMessageState>(
      bloc: context.read<ListMessageBloc>()
        ..add(OnListMessageEvent(data: {
          "discussionId": itemDiscussionModel.id,
        })),
      builder: (BuildContext context, state) {
        final List<ItemMessageModel> messages =
            (state as ListMessageInitialState).messages;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final ItemMessageModel itemMessageModel = messages[index];
            return ListTile(
              title: Text(itemMessageModel.message),
            );
          },
        );
      },
    );
  }
}
