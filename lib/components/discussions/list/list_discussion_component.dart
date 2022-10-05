import "package:com_nicodevelop_boilerplate/components/discussions/item/item_discussion_component.dart";
import "package:com_nicodevelop_boilerplate/models/item_discussion_model.dart";
import "package:com_nicodevelop_boilerplate/models/user_model.dart";
import "package:com_nicodevelop_boilerplate/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_boilerplate/services/list_discussion/list_discussion_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListDiscussionComponent extends StatelessWidget {
  const ListDiscussionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationStatusBloc, AuthenticationStatusState>(
      builder: (context, authenticatedState) {
        final UserModel userModel =
            (authenticatedState as AuthenticatedStatusState).userModel;

        return BlocBuilder<ListDiscussionBloc, ListDiscussionState>(
          bloc: context.read<ListDiscussionBloc>()
            ..add(OnListDiscussionEvent()),
          builder: (context, state) {
            final List<ItemDiscussionModel> discussions =
                (state as ListDiscussionInitialState).discussions;

            return ListView.builder(
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                return ItemDiscussionComponent(
                  itemDiscussionModel: discussions[index],
                  userModel: userModel,
                );
              },
            );
          },
        );
      },
    );
  }
}
