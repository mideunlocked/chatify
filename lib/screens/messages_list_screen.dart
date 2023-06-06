import 'package:flutter/material.dart';

import '../widgets/message_list/message_app_bar.dart';
import '../widgets/message_list/message_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // custom app bar
            const MessagesAppBar(),

            // messages list
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => const MessageTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
