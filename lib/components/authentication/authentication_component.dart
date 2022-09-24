import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AuthenticationComponent extends StatelessWidget {
  final Widget authenticatedView;
  final Widget unauthenticatedView;

  const AuthenticationComponent({
    super.key,
    required this.authenticatedView,
    required this.unauthenticatedView,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationStatusBloc, AuthenticationStatusState>(
        builder: (context, state) {
      print(state);
      if (state is AuthenticatedStatusState) {
        return authenticatedView;
      } else if (state is UnauthenticatedStatusState) {
        return unauthenticatedView;
      }

      return const SizedBox.shrink();
    });
  }
}
