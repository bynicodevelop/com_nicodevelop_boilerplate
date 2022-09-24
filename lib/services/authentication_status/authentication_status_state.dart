part of "authentication_status_bloc.dart";

abstract class AuthenticationStatusState extends Equatable {
  const AuthenticationStatusState();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusInitialState extends AuthenticationStatusState {}

class AuthenticationStatusLoadingState extends AuthenticationStatusState {}

class AuthenticatedStatusState extends AuthenticationStatusState {}

class UnauthenticatedStatusState extends AuthenticationStatusState {}
