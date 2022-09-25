part of "bootstrap_bloc.dart";

abstract class BootstrapEvent extends Equatable {
  const BootstrapEvent();

  @override
  List<Object> get props => [];
}

class OnBootstrapEvent extends BootstrapEvent {
  final ReadyStartModel readyStartModel;

  const OnBootstrapEvent({
    required this.readyStartModel,
  });

  @override
  List<Object> get props => [
        readyStartModel,
      ];
}
