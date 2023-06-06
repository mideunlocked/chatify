import 'package:chatify/widgets/message_list/group_message_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/message_list/message_app_bar.dart';

class GroupMessagesScreen extends StatefulWidget {
  const GroupMessagesScreen({super.key});

  @override
  State<GroupMessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<GroupMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // custom app bar
          const MessagesAppBar(
            title: "Group messages",
          ),

          // messages list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => const GroupMessageTile(),
            ),
          ),
        ],
      ),
    );
  }
}
