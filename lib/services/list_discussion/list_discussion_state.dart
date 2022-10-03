part of "list_discussion_bloc.dart";

abstract class ListDiscussionState extends Equatable {
  const ListDiscussionState();

  @override
  List<Object> get props => [];
}

class ListDiscussionInitialState extends ListDiscussionState {
  final List<ItemDiscussionModel> discussions;

  const ListDiscussionInitialState({
    this.discussions = const [],
  });

  @override
  List<Object> get props => [
        discussions,
      ];
}
