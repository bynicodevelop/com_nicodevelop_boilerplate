// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/account_repository.dart";
import "package:equatable/equatable.dart";

part "update_account_event.dart";
part "update_account_state.dart";

class UpdateAccountBloc extends Bloc<UpdateAccountEvent, UpdateAccountState> {
  final AccountRepository accountRepository;

  UpdateAccountBloc({
    required this.accountRepository,
  }) : super(UpdateAccountInitialState()) {
    on<OnUpdateAccountEvent>((event, emit) async {
      emit(UpdateAccountLoadingState());

      try {
        await accountRepository.update(
          event.userModel.toMap(),
        );

        emit(UpdateAccountSuccessState());
      } on StandardException catch (e) {
        emit(UpdateAccountFailureState(
          code: e.code,
        ));
      }
    });
  }
}
