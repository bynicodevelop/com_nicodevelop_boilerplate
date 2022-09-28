import "package:com_nicodevelop_dotmessenger/components/profile/avatar/profile_avatar_component.dart";
import "package:com_nicodevelop_dotmessenger/components/profile/avatar/update/profile_avatar_update_wrapper.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/screens/settings_screen.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dot Messenger"),
        actions: [
          IconButton(
            onPressed: () async => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: ProfileAvatarUpdateWrapper(
          onAvatarUpdated: () {
            context
                .read<AuthenticationStatusBloc>()
                .add(OnRefreshAuthenticationStatusEvent());
          },
          child:
              BlocBuilder<AuthenticationStatusBloc, AuthenticationStatusState>(
            builder: (context, state) {
              final UserModel userModel =
                  (state as AuthenticatedStatusState).userModel;

              return ProfileAvatarComponent(
                username: userModel.email,
                photoURL: userModel.photoURL,
              );
            },
          ),
        ),
      ),
    );
  }
}
