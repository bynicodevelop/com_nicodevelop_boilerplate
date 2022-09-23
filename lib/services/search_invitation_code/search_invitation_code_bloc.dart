import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "search_invitation_code_event.dart";
part "search_invitation_code_state.dart";

class SearchInvitationCodeBloc
    extends Bloc<SearchInvitationCodeEvent, SearchInvitationCodeState> {
  SearchInvitationCodeBloc() : super(SearchInvitationCodeInitialState()) {
    on<OnSearchInvitationCodeEvent>((event, emit) {
      print(event.invitationCode);
    });
  }
}
