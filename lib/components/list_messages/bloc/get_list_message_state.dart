part of 'get_list_message_bloc.dart';

abstract class GetListMessageState extends Equatable {
  const GetListMessageState();

  @override
  List<Object> get props => [];
}

class GetListMessageInitialState extends GetListMessageState {
  final bool isLoading;
  final List<ItemMessageModel> listMessage;

  const GetListMessageInitialState({
    this.isLoading = false,
    this.listMessage = const [],
  });

  @override
  List<Object> get props => [
        isLoading,
        listMessage,
      ];
}
