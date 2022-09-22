import "package:com_nicodevelop_dotmessenger/components/item_message/item_message_component.dart";
import "package:com_nicodevelop_dotmessenger/components/list_messages/bloc/get_list_message_bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListMessagesComponent extends StatelessWidget {
  const ListMessagesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListMessageBloc, GetListMessageState>(
      builder: (context, state) {
        final List<ItemMessageModel> listMessage =
            (state is GetListMessageInitialState) ? state.listMessage : [];

        return ListView.builder(
          itemCount: listMessage.length,
          itemBuilder: (context, index) {
            return ItemMessageComponent(
              itemMessage: listMessage[index],
            );
          },
        );
      },
    );
  }
}
