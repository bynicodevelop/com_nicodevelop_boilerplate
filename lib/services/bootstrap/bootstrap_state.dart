part of "bootstrap_bloc.dart";

abstract class BootstrapState extends Equatable {
  const BootstrapState();

  @override
  List<Object> get props => [];
}

class BootstrapInitialState extends BootstrapState {}

class BootstrapReadyState extends BootstrapState {}
