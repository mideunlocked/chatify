import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/chatting.dart';
import '../chat_widget/more_actions_dialog.dart';
import '../chat_widget/replied_widget.dart';
import 'gc_bubble_name.dart';

class GCChatBubble extends StatelessWidget {
  const GCChatBubble({
    super.key,
    required this.text,
    this.isMe = true,
    this.isRead = false,
    required this.time,
    required this.id,
    required this.reply,
    required this.date,
    required this.chatId,
    required this.senderId,
  });

  final String text;
  final String senderId;
  final String id;
  final String chatId;
  final bool isMe;
  final bool isRead;
  final String time;
  final String date;
  final Map<String, dynamic> reply;

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
      text: text,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    // bubble container final size
    final bubbleWidth = textPainter.width + 45;
    // String? username = FirebaseAuth.instance.currentUser?.displayName;

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment
              .centerLeft, // alignment for current user : alignment for other user
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onLongPress: () => showChatDetails(
          context,
        ),
        onDoubleTap: () {
          // replyChat(
          //   isMe == true ? username ?? "" : recieverUsername,
          //   text,
          //   id,
          //   context,
          // );
        },
        child: Stack(
          alignment: isMe == true ? Alignment.topRight : Alignment.topLeft,
          children: [
            reply["text"] == ""
                ? const Text("")
                : RepliedWidget(
                    isMe: isMe,
                    bubbleWidth: bubbleWidth,
                    reply: reply,
                  ),
            Container(
              margin: EdgeInsets.only(
                top: reply["text"] == "" ? 0 : 50.sp,
                left: isMe == true ? 70.sp : 10.sp,
                right: isMe == false ? 70.sp : 10.sp,
                bottom: 6.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              width: bubbleWidth,
              decoration: BoxDecoration(
                color: isMe == true
                    ? const Color.fromARGB(255, 192, 250, 223)
                    : const Color.fromARGB(255, 0, 34, 53),
                borderRadius: isMe == true ? borderRadius1 : borderRadius2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isMe == true
                      ? const SizedBox()
                      : GCBubbleName(
                          uid: senderId,
                        ),
                  Text(
                    text,
                    style: TextStyle(
                      color: isMe == true
                          ? const Color.fromARGB(255, 0, 34, 53)
                          : Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),
                  Icon(
                    Icons.circle_rounded,
                    color: isMe == true
                        ? isRead == true
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
      ),
    );
  }

  // function to call the show more info dialog
  void showChatDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MoreActionsDialog(
          isGC: true,
          isMe: isMe,
          text: text,
          time: time,
          date: date,
          isRead: isRead,
          chatid: chatId,
          id: id,
          recieverUsername: "",
        );
      },
    );
  }

  // function ot reply chat
  void replyChat(String name, String text, String id, context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.replyMessage(
      name,
      text,
    );
  }
}