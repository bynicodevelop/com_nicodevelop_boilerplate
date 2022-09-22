part of "get_list_message_bloc.dart";

abstract class GetListMessageEvent extends Equatable {
  const GetListMessageEvent();

  @override
  List<Object> get props => [];
}

class OnGetListMessageEvent extends GetListMessageEvent {}

class OnMessageLoadedEvent extends GetListMessageEvent {
  final List<ItemMessageModel> listMessage;

  const OnMessageLoadedEvent({
    required this.listMessage,
  });

  @override
  List<Object> get props => [
        listMessage,
      ];
}
