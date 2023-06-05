import 'package:chatify/models/chat.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/widgets/chat/reply_widget.dart';
import 'package:chatify/widgets/chat/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'send_icon.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  TextInputWidget({
    super.key,
    this.replyText = "",
    this.name = "",
    required this.isMe,
  });

  String replyText;
  String name;
  final bool isMe;

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

    return Column(
      children: [
        widget.replyText == ""
            ? const SizedBox()
            : ReplyWidget(
                replyText: widget.replyText,
                name: widget.name,
                isMe: widget.isMe,
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
                  chattingProvider.senMessage(
                    Chat(
                      id: "jaa",
                      timeStamp: 23,
                      reply: {
                        "name": widget.name,
                        "text": widget.replyText,
                      },
                      isMe: true,
                      isSeen: false,
                      isSent: false,
                      text: controller.text.trim(),
                    ),
                  );
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
