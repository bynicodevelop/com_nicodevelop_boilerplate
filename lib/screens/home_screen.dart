import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dot Messenger"),
      ),
      body: Center(
        child: Text(t(context)!.helloWorld),
      ),
    );
  }
}
