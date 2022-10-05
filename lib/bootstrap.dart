import "package:com_nicodevelop_boilerplate/services/bootstrap/bootstrap_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";

class Bootstrap extends StatelessWidget {
  final Widget child;

  const Bootstrap({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BootstrapBloc, BootstrapState>(
      listener: (context, state) {
        if ((state as BootstrapInitialState).isReady) {
          FlutterNativeSplash.remove();
        }
      },
      builder: (context, state) {
        return child;
      },
    );
  }
}
