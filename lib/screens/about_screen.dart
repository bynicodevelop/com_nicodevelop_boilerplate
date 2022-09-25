import "package:about_screen/about_screen.dart";
import "package:flutter/material.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
      ),
      body: Center(
        child: aboutScreen(
          "Dot Messenger",
          applicationVersion: "1.0.0",
          // applicationIcon: ...,
          applicationLegalese: "© 2021 Nico Develop",
        ),
      ),
    );
  }
}
