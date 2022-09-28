// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/repositories/authentication_repository.dart";
import "package:equatable/equatable.dart";

part "logout_event.dart";
part "logout_state.dart";

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationRepository authenticationRepository;

  LogoutBloc({
    required this.authenticationRepository,
  }) : super(LogoutInitialState()) {
    on<OnLogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());

      await authenticationRepository.logout();

      emit(LogoutSuccessState());
    });
  }
}
