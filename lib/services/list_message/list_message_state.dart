part of "list_message_bloc.dart";

abstract class ListMessageState extends Equatable {
  const ListMessageState();

  @override
  List<Object> get props => [];
}

class ListMessageInitialState extends ListMessageState {
  final List<ItemMessageModel> messages;

  const ListMessageInitialState({
    this.messages = const [],
  });

  @override
  List<Object> get props => [
        messages,
      ];
}
