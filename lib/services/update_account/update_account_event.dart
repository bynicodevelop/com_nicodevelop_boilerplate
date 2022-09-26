part of "update_account_bloc.dart";

abstract class UpdateAccountEvent extends Equatable {
  const UpdateAccountEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateAccountEvent extends UpdateAccountEvent {
  final UserModel userModel;

  const OnUpdateAccountEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}
