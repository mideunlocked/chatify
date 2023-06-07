import 'package:chatify/models/post.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/spaces/space_screen.dart';
import 'space_reaction.dart';

class LikeAndComment extends StatelessWidget {
  const LikeAndComment({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    var data = post;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // comment
        SpaceReaction(
          icon: Icons.comment_outlined,
          icon2: Icons.comment_rounded,
          count: "0",
          function: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => SpaceScreen(
                post: Post(
                  id: data.id,
                  text: data.text,
                  postUserInfo: {
                    "username": "",
                  },
                  time: data.time,
                  comments: data.comments,
                  likeCount: data.likeCount,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        // favourite
        SpaceReaction(
          icon: Icons.favorite_outline_rounded,
          icon2: Icons.favorite_rounded,
          count: "0",
          function: () {},
        ),
      ],
    );
  }
}
