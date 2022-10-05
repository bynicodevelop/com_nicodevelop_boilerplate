part of "authentication_status_bloc.dart";

class AuthenticationStatusStateInterface {
  late UserModel userModel;
}

abstract class AuthenticationStatusState extends Equatable {
  const AuthenticationStatusState();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusInitialState extends AuthenticationStatusState {}

class AuthenticationStatusLoadingState extends AuthenticationStatusState {}

class AuthenticatedStatusState extends AuthenticationStatusState {
  final UserModel userModel;

  const AuthenticatedStatusState({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}

class UnauthenticatedStatusState extends AuthenticationStatusState {
  final UserModel userModel;

  const UnauthenticatedStatusState({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}
