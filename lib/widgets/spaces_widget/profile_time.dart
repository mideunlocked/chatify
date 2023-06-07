import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileAcessTime extends StatelessWidget {
  const ProfileAcessTime({
    super.key,
    required this.time,
    required this.username,
    required this.profileUrl,
  });

  final String time;
  final String username;
  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 15.sp,
            ),
            Text(
              "~$time",
              style: const TextStyle(color: Colors.white60),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Text(
            "@$username",
            style: const TextStyle(color: Colors.white60),
          ),
        ),
      ],
    );
  }
}
