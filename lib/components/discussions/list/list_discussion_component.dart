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
          print(state);
          return Container();
        });
  }
}
