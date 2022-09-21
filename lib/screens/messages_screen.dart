import 'package:com_nicodevelop_dotmessenger/components/list_messages/list_messages_component.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListMessagesComponent(),
    );
  }
}
