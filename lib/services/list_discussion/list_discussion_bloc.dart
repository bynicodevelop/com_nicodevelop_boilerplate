// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_boilerplate/models/item_discussion_model.dart";
import "package:com_nicodevelop_boilerplate/repositories/discussion_repository.dart";
import "package:equatable/equatable.dart";

part "list_discussion_event.dart";
part "list_discussion_state.dart";

class ListDiscussionBloc
    extends Bloc<ListDiscussionEvent, ListDiscussionState> {
  final DiscussionRepository discussionRepository;

  ListDiscussionBloc({
    required this.discussionRepository,
  }) : super(const ListDiscussionInitialState()) {
    discussionRepository.discussions.listen(
      (event) => add(OnListLoadedDiscussionEvent(
        discussions: event,
      )),
    );

    on<OnListDiscussionEvent>((event, emit) async {
      await discussionRepository.list();
    });

    on<OnListLoadedDiscussionEvent>((event, emit) {
      emit(ListDiscussionInitialState(
        discussions: event.discussions,
      ));
    });
  }
}
