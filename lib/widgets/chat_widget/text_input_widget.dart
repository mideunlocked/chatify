import 'package:chatify/models/chat.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/widgets/chat_widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'reply_widget.dart';
import 'send_icon.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  TextInputWidget({
    super.key,
    this.replyText = "",
    this.name = "",
    required this.isMe,
    required this.index,
    required this.chatId,
    required this.isInitial,
    required this.recieverUid,
  });

  String replyText;
  String name;
  final String chatId;
  final int index;
  final bool isMe;
  bool isInitial;
  final String recieverUid;

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
    var chattingProvider = Provider.of<Chatting>(context, listen: false);
    var replyData = chattingProvider.reply;
    print(replyData["text"]);

    return Column(
      children: [
        replyData["text"] == ""
            ? Container()
            : ReplyWidget(
                replyText: replyData["text"] ?? "",
                name: replyData["name"] ?? "",
                isMe: replyData["isMe"] ?? false,
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
                          "index": widget.index,
                          "name": widget.name,
                          "text": widget.replyText,
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
                          "index": widget.index,
                          "name": widget.name,
                          "text": widget.replyText,
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
