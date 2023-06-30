import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatInfoBubble extends StatelessWidget {
  const ChatInfoBubble({
    super.key,
    required this.text,
    required this.allRead,
  });

  final String text;
  final bool allRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.sp,
        left: 70.sp,
        bottom: 6.sp,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 192, 250, 223),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 34, 53),
              fontSize: 11.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.circle_rounded,
                color: allRead == true ? Colors.green : Colors.grey,
                size: 5.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
