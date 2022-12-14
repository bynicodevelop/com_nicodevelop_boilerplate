part of "create_account_bloc.dart";

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAccountEvent extends CreateAccountEvent {
  final String displayName;
  final String email;
  final String password;

  const OnCreateAccountEvent({
    required this.displayName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        displayName,
        email,
        password,
      ];
}
