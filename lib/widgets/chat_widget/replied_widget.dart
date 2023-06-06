import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class RepliedWidget extends StatelessWidget {
  const RepliedWidget({
    super.key,
    required this.isMe,
    required this.bubbleWidth,
    required this.reply,
    required this.scrollController,
  });

  final bool isMe;
  final double bubbleWidth;
  final Map<String, dynamic> reply;
  final ItemScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    // calculate bubble container width using text span
    final textSpan = TextSpan(
      text: reply["text"],
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    // bubble container final size
    final bubbleWidth = textPainter.width + 35;

    return Padding(
      padding: EdgeInsets.only(
        left: isMe == true ? 30.sp : 10.sp,
        right: isMe == false ? 30.sp : 10.sp,
        top: 10.sp,
      ),
      child: InkWell(
        onTap: () {
          scrollController.scrollTo(
            index: reply["index"] ?? 0,
            alignment: 0.5,
            duration: const Duration(seconds: 1),
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 3.sp,
            left: 12.sp,
            right: 12.sp,
            bottom: 10.sp,
          ),
          alignment: Alignment.topLeft,
          width: bubbleWidth,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Text(
                reply["text"] ?? "",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
