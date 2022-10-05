part of "get_affiliate_code_bloc.dart";

abstract class GetAffiliateCodeState extends Equatable {
  const GetAffiliateCodeState();

  @override
  List<Object> get props => [];
}

class GetAffiliateCodeInitialState extends GetAffiliateCodeState {
  final String code;

  const GetAffiliateCodeInitialState({
    this.code = "",
  });

  @override
  List<Object> get props => [
        code,
      ];
}
