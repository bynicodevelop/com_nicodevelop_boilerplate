import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/models/profile_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/affiliate_repository.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
import "package:equatable/equatable.dart";

part "search_affiliate_code_event.dart";
part "search_affiliate_code_state.dart";

class SearchAffiliateCodeBloc
    extends Bloc<SearchAffiliateCodeEvent, SearchAffiliateCodeState> {
  final AffiliateRepository parrainageRepository;

  SearchAffiliateCodeBloc({
    required this.parrainageRepository,
  }) : super(SearchAffiliateCodeInitialState()) {
    on<OnSearchAffiliateCodeEvent>((event, emit) async {
      emit(SearchAffiliateCodeLoadingState());

      try {
        final ProfileModel profileModel = await parrainageRepository.get({
          "affiliateCode": event.affiliateCode,
        });

        info(
          "$runtimeType - OnSearchAffiliateCodeEvent",
          data: profileModel.toMap(),
        );

        emit(SearchAffiliateCodeSuccessState(
          profileModel: profileModel,
        ));
      } on StandardException catch (e) {
        error(
          "$runtimeType - ${e.code} - ${e.message}",
        );

        emit(SearchAffiliateCodeErrorState(
          code: e.code,
        ));
      }
    });
  }
}
