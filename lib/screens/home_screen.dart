import "package:com_nicodevelop_dotmessenger/components/profile/avatar/profile_avatar_component.dart";
import "package:com_nicodevelop_dotmessenger/components/profile/avatar/update/profile_avatar_update_wrapper.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/screens/settings_screen.dart";
import "package:com_nicodevelop_dotmessenger/screens/share_affiliate_code_screen.dart";
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
      body: const Center(
        child: ShareAffiliateCodeScreen(),
      ),
    );
  }
}
