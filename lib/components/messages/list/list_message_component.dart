import "package:com_nicodevelop_dotmessenger/components/messages/bubbles/bubble_message_component.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/models/item_discussion_model.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/services/list_message/list_message_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListMessageComponent extends StatelessWidget {
  final ItemDiscussionModel itemDiscussionModel;
  final UserModel userModel;

  const ListMessageComponent({
    Key? key,
    required this.itemDiscussionModel,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMessageBloc, ListMessageState>(
      bloc: context.read<ListMessageBloc>()
        ..add(
          OnListMessageEvent(data: {
            "discussionId": itemDiscussionModel.id,
          }),
        ),
      builder: (BuildContext context, state) {
        final List<ItemMessageModel> messages =
            (state as ListMessageInitialState).messages;
        return ListView.separated(
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final ItemMessageModel itemMessageModel = messages[index];

            return BubbleMessageComponent(
              itemMessageModel: itemMessageModel,
              isMe: itemMessageModel.from.id == userModel.uid,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: kDefaultPadding,
            );
          },
        );
      },
    );
  }
}
