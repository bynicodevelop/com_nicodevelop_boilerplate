import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:settings_screen/settings_screen.dart";
import "./about_screen.dart";
import "./profile_screen.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: settingsScreen([
        {
          "title": "Profile",
          "subtitle": "Edit your profile",
          "onTap": () async {
            final UserModel userModel = (context
                    .read<AuthenticationStatusBloc>()
                    .state as AuthenticatedStatusState)
                .userModel;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userModel: userModel,
                ),
              ),
            );
          },
        },
        {
          "title": "About",
          "subtitle": "Version 1.0.0",
          "onTap": () async => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              ),
        },
      ]),
    );
  }
}
