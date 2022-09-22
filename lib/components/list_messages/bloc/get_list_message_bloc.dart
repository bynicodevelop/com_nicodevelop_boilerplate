// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/messages_repository.dart";
import "package:equatable/equatable.dart";

part "get_list_message_event.dart";
part "get_list_message_state.dart";

class GetListMessageBloc
    extends Bloc<GetListMessageEvent, GetListMessageState> {
  final MessagesRepository messageRepository;

  GetListMessageBloc({
    required this.messageRepository,
  }) : super(const GetListMessageInitialState()) {
    messageRepository.messagesStream.listen((
      List<ItemMessageModel> listMessage,
    ) =>
        add(OnMessageLoadedEvent(
          listMessage: listMessage,
        )));

    on<OnMessageLoadedEvent>((event, emit) {
      emit(GetListMessageInitialState(
        listMessage: event.listMessage,
      ));
    });

    on<OnGetListMessageEvent>((event, emit) async {
      emit(GetListMessageInitialState(
        isLoading: true,
        listMessage: (state as GetListMessageInitialState).listMessage,
      ));

      await messageRepository.list();
    });
  }
}
