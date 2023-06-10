import 'package:chatify/helpers/date_time_formatting.dart';
import 'package:chatify/models/post.dart';
import 'package:chatify/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'like_and_comment.dart';
import 'profile_time.dart';

class SpacePostWidget extends StatefulWidget {
  const SpacePostWidget({
    super.key,
    required this.post,
    required this.index,
  });

  final Post post;
  final int index;

  @override
  State<SpacePostWidget> createState() => _SpacePostWidgetState();
}

class _SpacePostWidgetState extends State<SpacePostWidget> {
  @override
  Widget build(BuildContext context) {
    String timeAgo = DateTimeFormatting().timeAgo(widget.post.time);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // this widgets hold the username, user profile image and the time posted
          ProfileAcessTime(
            time: timeAgo,
            profileUrl: widget.post.postUserInfo["profileImageUrl"] ?? "",
            username: widget.post.postUserInfo["username"],
          ),
          SizedBox(
            height: 2.h,
          ),

          // this widgets holds the space text
          Text(
            widget.post.text,
          ),
          SizedBox(
            height: 3.h,
          ),

          // this holds the Like and comment buttons
          Stack(
            alignment: Alignment.centerRight,
            children: [
              LikeAndComment(
                post: widget.post,
                index: widget.index,
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delete"),
                        SizedBox(
                          width: 3.w,
                        ),
                        const Icon(
                          Icons.delete_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    deletePost(context);
                  }
                },
                child: Image.asset(
                  "assets/icons/more.png",
                  color: Colors.white60,
                  height: 3.h,
                  width: 3.w,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deletePost(BuildContext context) async {
    var postProvider = Provider.of<PostProvider>(context, listen: false);

    await postProvider.deletePost(widget.post.id, widget.index);
  }
}
