import "package:com_nicodevelop_dotmessenger/models/ready_start_model.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/bootstrap/bootstrap_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
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
    return BlocConsumer<AuthenticationStatusBloc, AuthenticationStatusState>(
        listener: ((context, state) {
      info("$runtimeType: Update boostrap state");

      ReadyStartModel readyStartModel =
          (context.read<BootstrapBloc>().state as BootstrapInitialState)
              .readyStartModel;

      if (state is AuthenticatedStatusState ||
          state is UnauthenticatedStatusState) {
        context.read<BootstrapBloc>().add(OnBootstrapEvent(
              readyStartModel: readyStartModel.copyWith(
                authenticationStatus: true,
              ),
            ));
      }
    }), builder: (context, state) {
      if (state is AuthenticatedStatusState) {
        return authenticatedView;
      } else if (state is UnauthenticatedStatusState) {
        return unauthenticatedView;
      }

      return const SizedBox.shrink();
    });
  }
}
