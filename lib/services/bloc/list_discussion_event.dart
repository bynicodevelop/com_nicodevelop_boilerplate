part of "list_discussion_bloc.dart";

abstract class ListDiscussionEvent extends Equatable {
  const ListDiscussionEvent();

  @override
  List<Object> get props => [];
}

class OnListDiscussionEvent extends ListDiscussionEvent {}

class OnListLoadedDiscussionEvent extends ListDiscussionEvent {
  final List<ItemDiscussionModel> discussions;

  const OnListLoadedDiscussionEvent({
    required this.discussions,
  });

  @override
  List<Object> get props => [
        discussions,
      ];
}
