part of "authentication_status_bloc.dart";

abstract class AuthenticationStatusEvent extends Equatable {
  const AuthenticationStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAuthenticationStatusEvent extends AuthenticationStatusEvent {
  final UserModel userModel;

  const OnAuthenticationStatusEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}

class OnRefreshAuthenticationStatusEvent extends AuthenticationStatusEvent {}
