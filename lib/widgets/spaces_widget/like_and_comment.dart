import 'package:chatify/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/spaces/space_screen.dart';
import 'space_reaction.dart';

// ignore: must_be_immutable
class LikeAndComment extends StatefulWidget {
  LikeAndComment({
    super.key,
    required this.post,
    required this.index,
    required this.isLiked,
  });

  final Post post;
  final int index;
  bool isLiked;

  @override
  State<LikeAndComment> createState() => _LikeAndCommentState();
}

class _LikeAndCommentState extends State<LikeAndComment> {
  // bool isLiked = false;

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    widget.isLiked = widget.post.likeCount.contains(uid);
  }

  void toggleLike() {
    setState(() {
      widget.isLiked = !widget.isLiked;
    });

    DocumentReference ref =
        FirebaseFirestore.instance.collection("posts").doc(widget.post.id);

    if (widget.isLiked) {
      ref.update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    } else {
      ref.update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // comment
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("posts")
                .doc(widget.post.id)
                .collection("comments")
                .get(),
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SpaceScreen(
                      index: widget.index,
                      isLiked: widget.isLiked,
                      post: Post(
                        id: widget.post.id,
                        text: widget.post.text,
                        postUserInfo: {
                          "username": "",
                        },
                        time: widget.post.time,
                        likeCount: widget.post.likeCount,
                      ),
                    ),
                  ),
                ),
                child: SpaceReaction(
                  icon: Icons.comment_outlined,
                  icon2: Icons.comment_rounded,
                  count: snapshot.data?.size.toString() ?? "0",
                ),
              );
            }),
        SizedBox(
          width: 15.w,
        ),
        // favourite
        GestureDetector(
          onTap: toggleLike,
          child: SpaceReaction(
            icon: Icons.favorite_outline_rounded,
            icon2: Icons.favorite_rounded,
            isActive: widget.isLiked,
            count: widget.post.likeCount.length.toString(),
          ),
        ),
      ],
    );
  }
}
