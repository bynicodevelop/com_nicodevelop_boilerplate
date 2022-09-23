part of "search_affiliate_code_bloc.dart";

abstract class SearchAffiliateCodeState extends Equatable {
  const SearchAffiliateCodeState();

  @override
  List<Object> get props => [];
}

class SearchAffiliateCodeInitialState extends SearchAffiliateCodeState {}

class SearchAffiliateCodeLoadingState extends SearchAffiliateCodeState {}

class SearchAffiliateCodeSuccessState extends SearchAffiliateCodeState {
  final ProfileModel profileModel;

  const SearchAffiliateCodeSuccessState({
    required this.profileModel,
  });

  @override
  List<Object> get props => [
        profileModel,
      ];
}

class SearchAffiliateCodeErrorState extends SearchAffiliateCodeState {
  final String code;

  const SearchAffiliateCodeErrorState({
    required this.code,
  });

  @override
  List<Object> get props => [
        code,
      ];
}
