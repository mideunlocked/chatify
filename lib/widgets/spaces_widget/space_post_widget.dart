import 'package:chatify/models/post.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'like_and_comment.dart';
import 'profile_time.dart';

class SpacePostWidget extends StatelessWidget {
  const SpacePostWidget({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // this widgets hold the username, user profile image and the time posted
          ProfileAcessTime(
            time: post.time,
            profileUrl: post.postUserInfo["profileUrl"] ?? "",
            username: post.postUserInfo["username"],
          ),
          SizedBox(
            height: 2.h,
          ),

          // this widgets holds the space text
          Text(
            post.text,
          ),
          SizedBox(
            height: 3.h,
          ),

          // this holds the Like and comment buttons
          LikeAndComment(
            post: post,
          ),
        ],
      ),
    );
  }
}
