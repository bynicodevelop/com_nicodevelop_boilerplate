part of "list_message_bloc.dart";

abstract class ListMessageEvent extends Equatable {
  const ListMessageEvent();

  @override
  List<Object> get props => [];
}

class OnListMessageEvent extends ListMessageEvent {
  final Map<String, dynamic> data;

  const OnListMessageEvent({
    required this.data,
  });

  @override
  List<Object> get props => [
        data,
      ];
}

class OnListMessageLoadingEvent extends ListMessageEvent {
  final List<ItemMessageModel> messages;

  const OnListMessageLoadingEvent({
    required this.messages,
  });

  @override
  List<Object> get props => [
        messages,
      ];
}
