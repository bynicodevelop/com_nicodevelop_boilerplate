part of "create_account_bloc.dart";

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAccountEvent extends CreateAccountEvent {
  final String email;
  final String password;
  final String affiliateCode;

  const OnCreateAccountEvent({
    required this.email,
    required this.password,
    required this.affiliateCode,
  });

  @override
  List<Object> get props => [
        email,
        password,
        affiliateCode,
      ];
}
