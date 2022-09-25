import "package:flutter/material.dart";
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
          "onTap": () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen())),
        },
        {
          "title": "About",
          "subtitle": "Version 1.0.0",
          "onTap": () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutScreen())),
        },
      ]),
    );
  }
}
