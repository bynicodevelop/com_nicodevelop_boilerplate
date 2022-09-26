// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/account_repository.dart";
import "package:equatable/equatable.dart";

part "delete_account_event.dart";
part "delete_account_state.dart";

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final AccountRepository accountRepository;

  DeleteAccountBloc({
    required this.accountRepository,
  }) : super(DeleteAccountInitialState()) {
    on<DeleteAccountEvent>((event, emit) async {
      emit(DeleteAccountLoadingState());

      try {
        await accountRepository.delete();

        emit(DeleteAccountSuccessState());
      } on StandardException catch (e) {
        emit(DeleteAccountFailureState(
          code: e.code,
        ));
      }
    });
  }
}
