// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/models/ready_start_model.dart";
import "package:equatable/equatable.dart";

part "bootstrap_event.dart";
part "bootstrap_state.dart";

class BootstrapBloc extends Bloc<BootstrapEvent, BootstrapState> {
  BootstrapBloc()
      : super(BootstrapInitialState(
          readyStartModel: ReadyStartModel(),
        )) {
    on<OnBootstrapEvent>((event, emit) {
      emit(BootstrapInitialState(
        readyStartModel: event.readyStartModel,
      ));
    });
  }
}
