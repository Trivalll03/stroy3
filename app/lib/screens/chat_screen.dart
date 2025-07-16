import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String rubricId;

  const ChatScreen({super.key, required this.rubricId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Чат")),
      body: Center(
        child: Text("Чат по рубрике ID: $rubricId"),
      ),
    );
  }
}
