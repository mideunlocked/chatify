import 'package:chatify/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/spaces/space_screen.dart';
import 'space_reaction.dart';

class LikeAndComment extends StatefulWidget {
  const LikeAndComment({
    super.key,
    required this.post,
    required this.index,
  });

  final Post post;
  final int index;

  @override
  State<LikeAndComment> createState() => _LikeAndCommentState();
}

class _LikeAndCommentState extends State<LikeAndComment> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference ref =
        FirebaseFirestore.instance.collection("posts").doc(widget.post.id);
    String uid = FirebaseAuth.instance.currentUser!.uid;

    if (isLiked == true) {
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
    var data = widget.post;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // comment
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("posts")
                .doc(data.id)
                .collection("comments")
                .get(),
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SpaceScreen(
                      index: widget.index,
                      post: Post(
                        id: data.id,
                        text: data.text,
                        postUserInfo: {
                          "username": "",
                        },
                        time: data.time,
                        likeCount: data.likeCount,
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
          onTap: () => toggleLike(),
          child: SpaceReaction(
            icon: Icons.favorite_outline_rounded,
            icon2: Icons.favorite_rounded,
            isActive: isLiked,
            count: data.likeCount.length.toString(),
          ),
        ),
      ],
    );
  }
}
