part of "update_account_bloc.dart";

abstract class UpdateAccountState extends Equatable {
  const UpdateAccountState();

  @override
  List<Object> get props => [];
}

class UpdateAccountInitialState extends UpdateAccountState {}

class UpdateAccountLoadingState extends UpdateAccountState {}

class UpdateAccountSuccessState extends UpdateAccountState {}

class UpdateAccountFailureState extends UpdateAccountState {
  final String code;

  const UpdateAccountFailureState({
    required this.code,
  });

  @override
  List<Object> get props => [
        code,
      ];
}
