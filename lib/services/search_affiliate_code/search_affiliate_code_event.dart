part of "search_affiliate_code_bloc.dart";

abstract class SearchAffiliateCodeEvent extends Equatable {
  const SearchAffiliateCodeEvent();

  @override
  List<Object> get props => [];
}

class OnSearchAffiliateCodeEvent extends SearchAffiliateCodeEvent {
  final String affiliateCode;

  const OnSearchAffiliateCodeEvent({
    required this.affiliateCode,
  });

  @override
  List<Object> get props => [
        affiliateCode,
      ];
}
