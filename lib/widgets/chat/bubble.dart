import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../providers/chatting.dart';
import 'more_actions_dialog.dart';
import 'replied_widget.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.text,
    this.isMe = true,
    this.isRead = false,
    required this.id,
    required this.reply,
    required this.index,
    required this.scrollController,
  });

  final String text;
  final String id;
  final bool isMe;
  final int index;
  final bool isRead;
  final Map<String, dynamic> reply;
  final ItemScrollController scrollController;

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
          replyChat(
            isMe == true ? "You" : "Uber Driver",
            text,
            index,
            context,
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            reply.isEmpty == true
                ? const Text("")
                : RepliedWidget(
                    isMe: isMe,
                    bubbleWidth: bubbleWidth,
                    reply: reply,
                    scrollController: scrollController,
                  ),
            Container(
              margin: EdgeInsets.only(
                top: reply.isEmpty == true ? 0 : 30.sp,
                left: isMe == true ? 70.sp : 10.sp,
                right: isMe == false ? 70.sp : 10.sp,
                bottom: 6.sp,
              ),
              padding: EdgeInsets.only(
                top: 12.sp,
                left: 12.sp,
                right: 12.sp,
                bottom: 3.sp,
              ),
              width: bubbleWidth,
              decoration: BoxDecoration(
                color: isMe == true
                    ? const Color.fromARGB(255, 192, 250, 223)
                    : const Color.fromARGB(255, 0, 34, 53),
                borderRadius: isMe == true ? borderRadius1 : borderRadius2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: isMe == true
                          ? const Color.fromARGB(255, 0, 34, 53)
                          : Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),

                  // widget to notify when a message as been delivered and seen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 10.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              isMe == true ? Colors.green : Colors.transparent,
                        ),
                        child: const Text(" "),
                      ),
                    ],
                  ),
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
          isMe: isMe,
          text: text,
          id: id,
          index: index,
        );
      },
    );
  }

  // function ot reply chat
  void replyChat(String name, String text, int index, context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);
    print("Index is: $index");

    chattingProvider.replyMessage(name, text, index);
  }
}
