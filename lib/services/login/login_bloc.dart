// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
