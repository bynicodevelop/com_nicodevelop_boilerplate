// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/account_repository.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
import "package:equatable/equatable.dart";

part "create_account_event.dart";
part "create_account_state.dart";

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final AccountRepository accountRepository;

  CreateAccountBloc({
    required this.accountRepository,
  }) : super(CreateAccountInitialState()) {
    on<OnCreateAccountEvent>((event, emit) async {
      emit(CreateAccountLoadingState());

      try {
        await accountRepository.create({
          "email": event.email,
          "password": event.password,
          "affiliateCode": event.affiliateCode,
        });

        info(
          "$runtimeType - Account created",
          data: {
            "email": event.email,
            "affiliateCode": event.affiliateCode,
          },
        );

        emit(CreateAccountSuccessState());
      } on StandardException catch (e) {
        emit(CreateAccountFailureState(
          code: e.code,
        ));
      }
    });
  }
}
