part of "list_message_bloc.dart";

abstract class ListMessageState extends Equatable {
  const ListMessageState();

  @override
  List<Object> get props => [];
}

class ListMessageInitialState extends ListMessageState {
  final List<ItemMessageModel> messages;
  final int refresh;

  const ListMessageInitialState({
    this.messages = const [],
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        messages,
        refresh,
      ];
}
