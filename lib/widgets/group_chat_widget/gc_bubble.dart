import 'package:chatify/providers/group_chatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../chat_widget/more_actions_dialog.dart';
import '../chat_widget/replied_widget.dart';
import 'gc_bubble_name.dart';

class GCChatBubble extends StatefulWidget {
  const GCChatBubble({
    super.key,
    required this.text,
    this.isMe = true,
    required this.time,
    required this.id,
    required this.reply,
    required this.date,
    required this.chatId,
    required this.senderId,
    required this.haveRead,
    required this.numberOfMembers,
  });

  final String text;
  final String senderId;
  final String id;
  final String chatId;
  final bool isMe;
  final List<dynamic> haveRead;
  final int numberOfMembers;
  final String time;
  final String date;
  final Map<String, dynamic> reply;

  @override
  State<GCChatBubble> createState() => _GCChatBubbleState();
}

class _GCChatBubbleState extends State<GCChatBubble> {
  String username = "";

  @override
  Widget build(BuildContext context) {
    // border radius for bubbles from me
    const borderRadius1 = BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    // border radius for bubbles from other user
    const borderRadius2 = BorderRadius.only(
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    // calculate bubble container width using text span
    final textSpan = TextSpan(
      text: widget.text,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    // bubble container final size
    final bubbleWidth = textPainter.width + 50;
    String? currentUsername = FirebaseAuth.instance.currentUser?.displayName;
    FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

    return Align(
      alignment: widget.isMe
          ? Alignment.centerRight
          : Alignment
              .centerLeft, // alignment for current user : alignment for other user
      child: FutureBuilder(
          future: cloudInstance.collection("users").doc(widget.senderId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            Map<String, dynamic>? data =
                snapshot.data?.data() as Map<String, dynamic>?;

            username = data?["username"] ?? "";

            return InkWell(
              borderRadius: BorderRadius.circular(30),
              onLongPress: () => showChatDetails(
                context,
              ),
              onDoubleTap: () {
                replyChat(
                  widget.isMe == true
                      ? currentUsername ?? ""
                      : data?["username"] ?? "",
                  widget.text,
                  widget.id,
                  context,
                );
              },
              child: Stack(
                alignment: widget.isMe == true
                    ? Alignment.topRight
                    : Alignment.topLeft,
                children: [
                  widget.reply["text"] == ""
                      ? const Text("")
                      : RepliedWidget(
                          isMe: widget.isMe,
                          bubbleWidth: bubbleWidth,
                          reply: widget.reply,
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      top: widget.reply["text"] == "" ? 0 : 60.sp,
                      left: widget.isMe == true ? 60.sp : 10.sp,
                      right: widget.isMe == false ? 60.sp : 10.sp,
                      bottom: 6.sp,
                    ),
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: widget.isMe == true
                          ? const Color.fromARGB(255, 192, 250, 223)
                          : const Color.fromARGB(255, 0, 34, 53),
                      borderRadius:
                          widget.isMe == true ? borderRadius1 : borderRadius2,
                    ),
                    child: Column(
                      crossAxisAlignment: widget.isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        widget.isMe == true
                            ? const SizedBox()
                            : GCBubbleName(
                                uid: widget.senderId,
                              ),
                        Text(
                          widget.text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: widget.isMe == true
                                ? const Color.fromARGB(255, 0, 34, 53)
                                : Colors.white,
                            fontSize: 11.sp,
                          ),
                        ),
                        Icon(
                          Icons.circle_rounded,
                          color: widget.isMe == true
                              ? widget.haveRead.length == widget.numberOfMembers
                                  ? Colors.green
                                  : Colors.grey
                              : Colors.transparent,
                          size: 5.sp,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // function to call the show more info dialog
  void showChatDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MoreActionsDialog(
          isGC: true,
          isMe: widget.isMe,
          text: widget.text,
          time: widget.time,
          date: widget.date,
          isRead:
              widget.haveRead.length == widget.numberOfMembers ? true : false,
          chatid: widget.chatId,
          id: widget.id,
          recieverUsername: username,
          readBy: widget.haveRead,
        );
      },
    );
  }

  // function ot reply chat
  void replyChat(String name, String text, String id, context) {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    groupChatProvider.replyMessage(
      name,
      text,
    );
  }
}
