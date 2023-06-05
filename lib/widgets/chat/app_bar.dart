import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white54,
          ),

          // title (Name, and isOnline)
          Column(
            children: [
              // name
              Text(
                "Uber driver",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              // isOnline
              Text(
                "Online",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),

          // profile picture
          CircleAvatar(
            backgroundColor: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
