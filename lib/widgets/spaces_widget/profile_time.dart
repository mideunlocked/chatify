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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.transparent,
            //   radius: 15.sp,
            // ),
            Text(
              "~$time",
              style: const TextStyle(color: Colors.white60),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.w),
          child: Row(
            children: [
              Text(
                "@$username",
                style: const TextStyle(color: Colors.white60),
              ),
              SizedBox(
                width: 1.w,
              ),
              username == "chatify"
                  ? const Icon(
                      Icons.verified_rounded,
                      color: Colors.amber,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
