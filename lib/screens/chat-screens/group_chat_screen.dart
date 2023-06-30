import 'package:chatify/helpers/date_time_formatting.dart';
import 'package:chatify/providers/group_chatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/group_chat.dart';
import '../../widgets/chat_widget/text_input_widget.dart';
import '../../widgets/general_widget/custom_progress_indicator.dart';
import '../../widgets/group_chat_widget/gc_app_bar.dart';
import '../../widgets/group_chat_widget/gc_bubble.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key, required this.groupChat});

  final ListGroupChat groupChat;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  void initState() {
    super.initState();

    clearReply();
  }

  void clearReply() {
    Provider.of<GroupChatting>(context, listen: false).initialClearReply();
  }

  @override
  Widget build(BuildContext context) {
    var authInstance = FirebaseAuth.instance;
    String? uid = authInstance.currentUser?.uid;
    var groupChattingProvider =
        Provider.of<GroupChatting>(context, listen: false);
    var id = widget.groupChat.id;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            GCChatScreenAppBar(
              groupId: widget.groupChat.id,
              about: widget.groupChat.about,
              admins: widget.groupChat.admins,
              requests: widget.groupChat.requests,
              participants: widget.groupChat.recipients.length,
            ),

            // chat's widget
            Expanded(
              child: StreamBuilder(
                  stream: groupChattingProvider.getMessages(id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CustomProgressIndicator();
                    } else if (snapshot.hasData == false ||
                        snapshot.data?.size == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Send the first message to the group",
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

                        List<dynamic>? isSeen = chat["isSeen"] ?? [];
                        var dateTime = DateTimeFormatting()
                            .formatTimeDate(chat["timeStamp"]);

                        if (chat["senderId"] != uid &&
                            isSeen!.contains(uid) == false) {
                          groupChattingProvider.markMessageAsRead(
                            widget.groupChat.id,
                            chatData.id,
                          );
                        }

                        return GCChatBubble(
                          text: chat["text"] ?? "",
                          senderId: chat["senderId"] ?? "",
                          isMe: chat["senderId"] == uid ? true : false,
                          id: chatData.id,
                          chatId: widget.groupChat.id,
                          reply: chat["reply"] ?? {},
                          haveRead: chat["isSeen"],
                          numberOfMembers: widget.groupChat.recipients.length,
                          time: dateTime[0],
                          date: dateTime[1],
                        );
                      }).toList(),
                    );
                  }),
            ),

            // Text input widget
            TextInputWidget(
              isMe: true,
              recieverUid: "",
              recieverUsername: "",
              chatId: widget.groupChat.id,
              isInitial: false,
              isGroup: true,
            ),
          ],
        ),
      ),
    );
  }
}
