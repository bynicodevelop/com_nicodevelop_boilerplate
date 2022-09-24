// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/authentication_repository.dart";
import "package:equatable/equatable.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginInitialState()) {
    on<OnLoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        await authenticationRepository.login({
          "email": event.email,
          "password": event.password,
        });

        emit(LoginSuccessState());
      } on StandardException catch (e) {
        emit(LoginFailureState(
          code: e.code,
        ));
      }
    });
  }
}
