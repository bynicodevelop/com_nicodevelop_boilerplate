// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "bootstrap_event.dart";
part "bootstrap_state.dart";

class BootstrapBloc extends Bloc<BootstrapEvent, BootstrapState> {
  BootstrapBloc() : super(BootstrapInitialState()) {
    on<OnBootstrapEvent>((event, emit) async {
      emit(BootstrapReadyState());
    });
  }
}
