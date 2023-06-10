import 'package:chatify/models/users.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widget/custom_back_button.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          const CustomBackButton(),

          // title (Name, and isOnline)
          Column(
            children: [
              // name
              Text(
                user.username,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              // isOnline
              Text(
                "",
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
