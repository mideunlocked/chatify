import 'package:chatify/models/post.dart';
import 'package:chatify/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'like_and_comment.dart';
import 'profile_time.dart';

class SpacePostWidget extends StatelessWidget {
  const SpacePostWidget({
    super.key,
    required this.post,
    required this.index,
    required this.isLiked,
  });

  final Post post;
  final int index;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // this widgets hold the username, user profile image and the time posted
          ProfileAcessTime(
            time: post.time.toDate().hour.toString(),
            profileUrl: post.postUserInfo["profileImageUrl"] ?? "",
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
          Stack(
            alignment: Alignment.centerRight,
            children: [
              LikeAndComment(
                post: post,
                index: index,
                isLiked: isLiked,
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

    await postProvider.deletePost(post.id, index);
  }
}
