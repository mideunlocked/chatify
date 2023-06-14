import 'package:chatify/models/chat.dart';
import 'package:chatify/providers/chatting.dart';
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
  });

  final String chatId;
  final bool isMe;
  bool isInitial;
  final String recieverUid;
  final String recieverUsername;

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
    String? username = FirebaseAuth.instance.currentUser?.displayName;

    return Column(
      children: [
        replyData["text"] == ""
            ? Container()
            : ReplyWidget(
                replyText: replyData["text"] ?? "",
                name: replyData["name"] ?? "",
                isMe: replyData["name"] == username ? true : false,
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
                  if (widget.isInitial == false) {
                    chattingProvider.senMessage(
                      Chat(
                        id: "jaa",
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
                    );
                    setState(() {
                      widget.isInitial = false;
                    });
                  }
                  chattingProvider.clearReply();
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
