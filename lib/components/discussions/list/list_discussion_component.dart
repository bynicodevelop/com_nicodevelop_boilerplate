import "package:com_nicodevelop_dotmessenger/components/discussions/item/item_discussion_component.dart";
import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/services/bloc/list_discussion_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListDiscussionComponent extends StatelessWidget {
  const ListDiscussionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListDiscussionBloc, ListDiscussionState>(
        bloc: context.read<ListDiscussionBloc>()..add(OnListDiscussionEvent()),
        builder: (context, state) {
          final List<ItemDiscussionModel> discussions =
              (state as ListDiscussionInitialState).discussions;
          return ListView.builder(
            itemCount: discussions.length,
            itemBuilder: (context, index) {
              return ItemDiscussionComponent(
                itemDiscussionModel: discussions[index],
              );
            },
          );
        });
  }
}
