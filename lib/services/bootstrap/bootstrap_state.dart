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

  @override
  List<Object> get props => [
        readyStartModel,
      ];
}

class BootstrapReadyState extends BootstrapState {}
