// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/repositories/affiliate_repository.dart";
import "package:equatable/equatable.dart";

part "get_affiliate_code_event.dart";
part "get_affiliate_code_state.dart";

class GetAffiliateCodeBloc
    extends Bloc<GetAffiliateCodeEvent, GetAffiliateCodeState> {
  final AffiliateRepository affiliateRepository;

  GetAffiliateCodeBloc({
    required this.affiliateRepository,
  }) : super(const GetAffiliateCodeInitialState()) {
    on<OnGetAffiliateCodeEvent>((event, emit) async {
      final String code = await affiliateRepository.getAffiliateCodeByUserId();

      emit(GetAffiliateCodeInitialState(
        code: code,
      ));
    });
  }
}
