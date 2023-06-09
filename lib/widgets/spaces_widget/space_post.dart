import 'package:chatify/models/post.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'space_post_widget.dart';

class SpacePost extends StatefulWidget {
  const SpacePost({
    super.key,
    required this.post,
    required this.index,
  });

  final Post post;
  final int index;

  @override
  State<SpacePost> createState() => _SpacePostState();
}

class _SpacePostState extends State<SpacePost> {
  @override
  Widget build(BuildContext context) {
    var spacePostWidget = SpacePostWidget(
      post: widget.post,
      index: widget.index,
    );
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => SpaceScreen(
        //       index: widget.index,
        //       post: widget.post,
        //       spacePostWidget: spacePostWidget,
        //     ),
        //   ),
        // );
        // showSpaceDialog();
      },
      child: Card(
        color: const Color.fromARGB(255, 0, 34, 53),
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: spacePostWidget,
      ),
    );
  }
}
