part of "get_affiliate_code_bloc.dart";

abstract class GetAffiliateCodeEvent extends Equatable {
  const GetAffiliateCodeEvent();

  @override
  List<Object> get props => [];
}

class OnGetAffiliateCodeEvent extends GetAffiliateCodeEvent {}
