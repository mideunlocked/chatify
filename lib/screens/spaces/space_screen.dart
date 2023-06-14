import 'package:chatify/models/comment.dart';
import 'package:chatify/models/post.dart';
import 'package:chatify/providers/comment_provider.dart';
import 'package:chatify/widgets/general_widget/app_bar_wide.dart';
import 'package:chatify/widgets/spaces_widget/comments/comment_widget.dart';
import 'package:chatify/widgets/spaces_widget/space_post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/spaces_widget/comments/comment_textfield.dart';

class SpaceScreen extends StatelessWidget {
  const SpaceScreen({
    super.key,
    required this.post,
    required this.index,
    required this.spacePostWidget,
  });

  final Post post;
  final int index;
  final SpacePostWidget spacePostWidget;

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      color: Colors.white30,
      thickness: 0.5,
    );

    var commentProvider = Provider.of<CommentProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarWide(title: "Space"),
            Expanded(
              child: ListView(
                children: [
                  divider,
                  Card(
                    color: const Color.fromARGB(255, 0, 34, 53),
                    margin:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SpacePostWidget(
                      post: post,
                      index: index,
                    ),
                  ),
                  divider,
                  StreamBuilder(
                      stream: commentProvider.getComments(post.id),
                      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                        // if (snapshot.hasError) {
                        //   return const Text('Something went wrong');
                        // } else if (snapshot.connectionState ==
                        //     ConnectionState.waiting) {
                        //   return const Text("Loading");
                        // } else if (snapshot.hasData == false) {
                        //   return const Text("No data");
                        // }

                        return Column(
                          children: snapshot.data?.docs
                                  .map((DocumentSnapshot commentData) {
                                Map<String, dynamic> comment =
                                    commentData.data()! as Map<String, dynamic>;

                                return CommentWidget(
                                  comment: Comment(
                                    id: commentData.id,
                                    post: post,
                                    time: comment["time"] ?? Timestamp.now(),
                                    comment: comment["comment"] ?? "",
                                    commenter: comment["commenter"] ?? {},
                                    likeCount: comment["likes"] ?? [],
                                    disLikeCount: comment["dislikes"] ?? [],
                                  ),
                                  divider: divider,
                                );
                              }).toList() ??
                              [
                                Icon(
                                  Icons.circle,
                                  color: Colors.white60,
                                  size: 10.sp,
                                ),
                              ],
                        );
                      }),
                ],
              ),
            ),
            divider,
            CommentTextField(
              id: post.id,
            ),
          ],
        ),
      ),
    );
  }
}
