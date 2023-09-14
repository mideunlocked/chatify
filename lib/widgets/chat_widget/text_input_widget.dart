import 'package:chatify/models/chat.dart';
import 'package:chatify/models/group_chat.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/chat_widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'reply_widget.dart';
import 'send_icon.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  TextInputWidget({
    super.key,
    required this.isMe,
    required this.chatId,
    required this.isInitial,
    required this.recieverUid,
    required this.recieverUsername,
    this.isGroup = false,
    required this.reciverToken,
  });

  final String chatId;
  final bool isMe;
  bool isInitial;
  final String recieverUid;
  final String recieverUsername;
  final bool isGroup;
  final String reciverToken;

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var chattingProvider = Provider.of<Chatting>(context);
    var replyData = chattingProvider.reply;
    var groupChatProvider = Provider.of<GroupChatting>(context);
    var gcReplyData = groupChatProvider.reply;
    String? username = FirebaseAuth.instance.currentUser?.displayName;

    return Column(
      children: [
        widget.isGroup == true
            ? Column(
                children: [
                  gcReplyData["text"] == ""
                      ? Container()
                      : ReplyWidget(
                          replyText: gcReplyData["text"] ?? "",
                          name: gcReplyData["name"] ?? "",
                          isMe: gcReplyData["name"] == username ? true : false,
                        ),
                ],
              )
            : Column(
                children: [
                  replyData["text"] == ""
                      ? Container()
                      : ReplyWidget(
                          replyText: replyData["text"] ?? "",
                          name: replyData["name"] ?? "",
                          isMe: replyData["name"] == username ? true : false,
                        ),
                ],
              ),
        Padding(
          padding: EdgeInsets.only(
            left: 7.sp,
            right: 7.sp,
            bottom: 10.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ChatTextField(controller: controller),
              SendIcon(
                function: () {
                  if (widget.isGroup == true) {
                    groupChatSend();
                  } else {
                    personalChatSend();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void groupChatSend() {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);
    var replyData = groupChatProvider.reply;

    groupChatProvider.sendMessage(
      GroupChat(
        id: "",
        senderId: "",
        timeStamp: Timestamp.now(),
        reply: {
          "name": replyData["name"] ?? "",
          "text": replyData["text"] ?? "",
        },
        isSeen: [],
        isSent: false,
        text: controller.text.trim(),
      ),
      widget.chatId,
    );

    controller.clear();
    groupChatProvider.clearReply();
  }

  void personalChatSend() {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);
    var replyData = chattingProvider.reply;

    if (widget.isInitial == false) {
      chattingProvider.sendMessage(
        Chat(
          id: "",
          timeStamp: Timestamp.now(),
          reply: {
            "name": replyData["name"] ?? "",
            "text": replyData["text"] ?? "",
          },
          isMe: true,
          isSeen: false,
          isSent: false,
          text: controller.text.trim(),
        ),
        widget.chatId,
        widget.recieverUid,
        widget.reciverToken,
      );
    } else {
      chattingProvider.startChat(
        widget.recieverUid,
        Chat(
          id: "",
          timeStamp: Timestamp.now(),
          reply: {
            "name": replyData["name"] ?? "",
            "text": replyData["text"] ?? "",
          },
          isMe: true,
          isSeen: false,
          isSent: false,
          text: controller.text.trim(),
        ),
        widget.reciverToken,
      );
      setState(() {
        widget.isInitial = false;
      });
    }
    chattingProvider.clearReply();
    controller.clear();
  }
}
