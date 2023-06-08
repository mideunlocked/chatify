import 'package:chatify/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../profile_time.dart';
import '../space_reaction.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.divider,
  });

  final Comment comment;
  final Divider divider;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 2.h,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profile access and time
          ProfileAcessTime(
            time: "1d",
            username: comment.commenter["username"] ?? "",
            profileUrl: comment.commenter["profileUrl"] ?? "",
          ),
          sizedBox,
          // comment here
          Text(
            comment.comment,
          ),
          sizedBox,

          // like and dislike buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // like
              SpaceReaction(
                icon: Icons.thumb_up_outlined,
                icon2: Icons.thumb_up_rounded,
                count: comment.likeCount.toString(),
              ),
              SizedBox(
                width: 15.w,
              ),
              // dislike
              SpaceReaction(
                icon: Icons.thumb_down_outlined,
                icon2: Icons.thumb_down_rounded,
                count: comment.disLikeCount.toString(),
              ),
            ],
          ),
          divider,
        ],
      ),
    );
  }
}
