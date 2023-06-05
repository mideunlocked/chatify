import 'package:chatify/providers/chatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/chat/app_bar.dart';
import '../widgets/chat/bubble.dart';
import '../widgets/chat/text_input_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var chattingProvider = Provider.of<Chatting>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ChatScreenAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: chattingProvider.chats
                        .map(
                          (chat) => ChatBubble(
                            text: chat.text,
                            isMe: chat.isMe,
                            isRead: chat.isSeen,
                            id: chat.id,
                            reply: chat.reply,
                          ),
                        )
                        .toList()),
              ),
            ),
            TextInputWidget(
              replyText: chattingProvider.reply["text"] ?? "",
              name: chattingProvider.reply["name"] ?? "",
              isMe: true,
            ),
          ],
        ),
      ),
    );
  }
}
