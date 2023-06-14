import 'package:chatify/models/post.dart';
import 'package:chatify/providers/comment_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:sizer/sizer.dart';

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

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    isLiked = widget.post.likeCount.contains(uid);
    print(isLiked);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference ref =
        FirebaseFirestore.instance.collection("posts").doc(widget.post.id);

    if (isLiked) {
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
    var commentProvider = Provider.of<CommentProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // comment
        StreamBuilder(
            stream: commentProvider.getComments(widget.post.id),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return SpaceReaction(
                icon: Icons.comment_outlined,
                icon2: Icons.comment_rounded,
                count: snapshot.data?.docs.length.toString() ?? "0",
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
            isActive: isLiked == true ? true : false,
            count: widget.post.likeCount.length.toString(),
          ),
        ),
      ],
    );
  }
}
