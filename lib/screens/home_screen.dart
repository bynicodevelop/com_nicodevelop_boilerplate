import "package:com_nicodevelop_dotmessenger/components/discussions/list/list_discussion_component.dart";
import "package:com_nicodevelop_dotmessenger/screens/settings_screen.dart";
import "package:flutter/material.dart";

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
        child: ListDiscussionComponent(),
      ),
    );
  }
}
