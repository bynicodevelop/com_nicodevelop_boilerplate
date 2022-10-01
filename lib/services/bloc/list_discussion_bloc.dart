import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/discussion_repository.dart";
import "package:equatable/equatable.dart";

part "list_discussion_event.dart";
part "list_discussion_state.dart";

class ListDiscussionBloc
    extends Bloc<ListDiscussionEvent, ListDiscussionState> {
  final DiscussionRepository discussionRepository;

  ListDiscussionBloc({
    required this.discussionRepository,
  }) : super(const ListDiscussionInitialState()) {
    discussionRepository.discussions.listen((event) {
      print(event);
    });

    on<OnListDiscussionEvent>((event, emit) async {
      await discussionRepository.list();
    });
  }
}
