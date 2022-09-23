part of "search_invitation_code_bloc.dart";

abstract class SearchInvitationCodeEvent extends Equatable {
  const SearchInvitationCodeEvent();

  @override
  List<Object> get props => [];
}

class OnSearchInvitationCodeEvent extends SearchInvitationCodeEvent {
  final String invitationCode;

  const OnSearchInvitationCodeEvent({
    required this.invitationCode,
  });

  @override
  List<Object> get props => [
        invitationCode,
      ];
}
