part of "bootstrap_bloc.dart";

abstract class BootstrapState extends Equatable {
  const BootstrapState();

  @override
  List<Object> get props => [];
}

class BootstrapInitialState extends BootstrapState {
  final ReadyStartModel readyStartModel;

  const BootstrapInitialState({
    required this.readyStartModel,
  });

  bool get isReady => readyStartModel.isReady();

  @override
  List<Object> get props => [
        readyStartModel,
      ];
}
