// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:equatable/equatable.dart";

part "update_account_event.dart";
part "update_account_state.dart";

class UpdateAccountBloc extends Bloc<UpdateAccountEvent, UpdateAccountState> {
  UpdateAccountBloc() : super(UpdateAccountInitialState()) {
    on<OnUpdateAccountEvent>((event, emit) async {});
  }
}
