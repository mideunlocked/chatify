import 'package:chatify/helpers/date_time_formatting.dart';
import 'package:chatify/models/users.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_widget/app_bar.dart';
import '../widgets/chat_widget/bubble.dart';
import '../widgets/chat_widget/text_input_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.user,
    required this.chatId,
    required this.recieverId,
  });

  final Users user;
  final String chatId;
  final String recieverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<Chatting>(context, listen: false).clearReply();
  }

  bool isInitial = false;

  @override
  Widget build(BuildContext context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            ChatScreenAppBar(user: widget.user),

            // chat's widget
            Expanded(
              child: StreamBuilder(
                  stream:
                      chattingProvider.getMessages([widget.recieverId, uid!]),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CustomProgressIndicator();
                    } else if (snapshot.hasData == false ||
                        snapshot.data?.size == 0) {
                      isInitial = true;
                      print(isInitial);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Send ${widget.user.username} a message",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white60),
                        ),
                      );
                    }

                    return ListView(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot chatData) {
                        Map<String, dynamic> chat =
                            chatData.data()! as Map<String, dynamic>;

                        var dateTime = DateTimeFormatting().formatTimeDate(
                            chat["timeStamp"] ?? Timestamp.now());

                        return ChatBubble(
                          text: chat["text"] ?? "",
                          isMe: chat["senderId"] == uid ? true : false,
                          isRead: chat["isSeen"] ?? false,
                          id: chatData.id,
                          chatId: widget.chatId,
                          reply: chat["reply"] ?? "",
                          time: dateTime[0],
                          date: dateTime[1],
                        );
                      }).toList(),
                    );
                  }),
            ),

            // Text input widget
            TextInputWidget(
              replyText: chattingProvider.reply["text"] ?? "",
              name: chattingProvider.reply["name"] ?? "",
              index: chattingProvider.reply["index"] ?? 0,
              isMe: true,
              chatId: widget.chatId,
              isInitial: isInitial,
              recieverUid: widget.recieverId,
            ),
          ],
        ),
      ),
    );
  }
}
