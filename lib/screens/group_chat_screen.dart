import 'package:chatify/helpers/date_time_formatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/group_chat.dart';
import '../widgets/chat_widget/text_input_widget.dart';
import '../widgets/group_chat_widget/gc_app_bar.dart';
import '../widgets/group_chat_widget/gc_bubble.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key, required this.groupChat});

  final ListGroupChat groupChat;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    var authInstance = FirebaseAuth.instance;
    String? uid = authInstance.currentUser?.uid;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            GCChatScreenAppBar(
              about: widget.groupChat.about,
              admins: widget.groupChat.admins,
              participants: widget.groupChat.recipients.length,
            ),

            // chat's widget
            Expanded(
              child: ListView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: widget.groupChat.chats.map((e) {
                  var dateTime =
                      DateTimeFormatting().formatTimeDate(e.timeStamp);

                  return GCChatBubble(
                    text: e.text,
                    senderId: e.senderId,
                    isMe: e.senderId == uid ? true : false,
                    isRead: e.isSeen.contains(uid),
                    id: e.id,
                    chatId: widget.groupChat.id,
                    reply: e.reply,
                    time: dateTime[0],
                    date: dateTime[1],
                  );
                }).toList(),
              ),
            ),

            // Text input widget
            TextInputWidget(
              isMe: true,
              recieverUid: "",
              recieverUsername: "",
              chatId: widget.groupChat.id,
              isInitial: false,
            ),
          ],
        ),
      ),
    );
  }
}
