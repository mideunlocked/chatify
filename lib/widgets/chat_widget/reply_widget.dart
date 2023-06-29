import 'package:chatify/providers/chatting.dart';
import 'package:chatify/providers/group_chatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ReplyWidget extends StatefulWidget {
  ReplyWidget({
    super.key,
    required this.name,
    required this.replyText,
    required this.isMe,
  });

  String name;
  String replyText;
  final bool isMe;

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      color: Colors.white24,
      margin: EdgeInsets.only(bottom: 6.sp),
      child: Row(
        children: [
          Container(
            width: 2.sp,
            height: double.infinity,
            color: widget.isMe == true
                ? const Color.fromARGB(255, 192, 250, 223)
                : const Color.fromARGB(255, 0, 34, 53),
            child: const Text(""),
          ),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
            width: 85.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: widget.isMe == true
                        ? const Color.fromARGB(255, 192, 250, 223)
                        : const Color.fromARGB(255, 0, 34, 53),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.replyText,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Provider.of<Chatting>(context, listen: false).clearReply();
                Provider.of<GroupChatting>(context, listen: false).clearReply();
              },
              child: const Icon(
                Icons.clear_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
