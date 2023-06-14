import 'package:chatify/models/comment.dart';
import 'package:chatify/providers/comment_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../helpers/date_time_formatting.dart';
import '../profile_time.dart';
import '../spaces_more_widget.dart';
import 'comment_reaction.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.divider,
  });

  final Comment comment;
  final Divider divider;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 2.h,
    );
    String timeAgo = DateTimeFormatting().timeAgo(widget.comment.time);
    var commentProvider = Provider.of<CommentProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profile access and time
          ProfileAcessTime(
            time: timeAgo,
            username: widget.comment.commenter["username"] ?? "",
            profileUrl: widget.comment.commenter["profileUrl"] ?? "",
          ),
          sizedBox,
          // comment here
          Text(
            widget.comment.comment,
          ),
          sizedBox,

          // like and dislike buttons
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // like
                  CommentReaction(
                    isActive: widget.comment.likeCount.contains(uid),
                    icon: Icons.thumb_up_outlined,
                    icon2: Icons.thumb_up_rounded,
                    count: widget.comment.likeCount.length.toString(),
                    toggleLike: () {
                      commentProvider.likeComment(
                        widget.comment.post.id,
                        widget.comment.id,
                        widget.comment.likeCount.contains(uid),
                      );
                    },
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  // dislike
                  CommentReaction(
                    isActive: widget.comment.disLikeCount.contains(uid),
                    icon: Icons.thumb_down_outlined,
                    icon2: Icons.thumb_down_rounded,
                    count: widget.comment.disLikeCount.length.toString(),
                    toggleLike: () {
                      commentProvider.dislikeComment(
                        widget.comment.post.id,
                        widget.comment.id,
                        widget.comment.disLikeCount.contains(uid),
                      );
                    },
                  ),
                ],
              ),
              widget.comment.commenter["userId"] == uid
                  ? PostCommentMoreWidget(
                      moreFunction: () => deletePost(context),
                    )
                  : const Text(""),
            ],
          ),
          widget.divider,
        ],
      ),
    );
  }

  void deletePost(BuildContext context) async {
    var commentProvider = Provider.of<CommentProvider>(context, listen: false);

    await commentProvider.deleteComment(
      widget.comment.post.id,
      widget.comment.id,
    );
  }
}
