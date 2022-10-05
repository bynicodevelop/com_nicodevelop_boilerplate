// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_boilerplate/repositories/item_message_model.dart";
import "package:com_nicodevelop_boilerplate/repositories/message_repository.dart";
import "package:equatable/equatable.dart";

part "list_message_event.dart";
part "list_message_state.dart";

class ListMessageBloc extends Bloc<ListMessageEvent, ListMessageState> {
  final MessageRepository messageRepository;

  ListMessageBloc({
    required this.messageRepository,
  }) : super(const ListMessageInitialState()) {
    messageRepository.messages.listen((List<ItemMessageModel> messages) {
      add(OnListMessageLoadingEvent(
        messages: messages,
      ));
    });

    on<OnListMessageEvent>((event, emit) async {
      await messageRepository.list(event.data);
    });

    on<OnListMessageLoadingEvent>((event, emit) {
      emit(ListMessageInitialState(
        messages: event.messages,
        refresh: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}
