import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UnreadIndicator extends StatelessWidget {
  const UnreadIndicator({
    super.key,
    required this.unreadCount,
  });

  final String? unreadCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 5.w,
      margin: EdgeInsets.only(top: 10.sp),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 192, 250, 223),
        shape: BoxShape.circle,
      ),
      child: Text(
        unreadCount ?? "0",
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 34, 53),
        ),
      ),
    );
  }
}
