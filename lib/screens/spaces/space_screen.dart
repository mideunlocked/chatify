import 'package:chatify/models/post.dart';
import 'package:chatify/widgets/general_widget/app_bar_wide.dart';
import 'package:chatify/widgets/spaces_widget/space_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/spaces_widget/comments/comment_textfield.dart';
import '../../widgets/spaces_widget/comments/comment_widget.dart';

class SpaceScreen extends StatelessWidget {
  const SpaceScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      color: Colors.white30,
      thickness: 0.5,
    );

    var data = post;
    var comment = data.comments[0];

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
                    child: SpacePostWidget(post: data),
                  ),
                  divider,
                  CommentWidget(comment: comment, divider: divider),
                  CommentWidget(comment: comment, divider: divider),
                  CommentWidget(comment: comment, divider: divider),
                  CommentWidget(comment: comment, divider: divider),
                ],
              ),
            ),
            divider,
            const CommentTextField(),
          ],
        ),
      ),
    );
  }
}
