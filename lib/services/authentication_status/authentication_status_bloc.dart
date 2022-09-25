// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/authentication_repository.dart";
import "package:equatable/equatable.dart";

part "authentication_status_event.dart";
part "authentication_status_state.dart";

class AuthenticationStatusBloc
    extends Bloc<AuthenticationStatusEvent, AuthenticationStatusState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationStatusBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationStatusInitialState()) {
    authenticationRepository.user.listen(
      (UserModel userModel) {
        add(OnAuthenticationStatusEvent(
          userModel: userModel,
        ));
      },
    );

    on<OnAuthenticationStatusEvent>((event, emit) {
      if (event.userModel.isEmpty()) {
        emit(UnauthenticatedStatusState(
          userModel: event.userModel,
        ));
      } else {
        emit(AuthenticatedStatusState(
          userModel: event.userModel,
        ));
      }
    });
  }
}
