import 'package:chatify/models/comment.dart';
import 'package:chatify/models/post.dart';
import 'package:chatify/widgets/spaces_widget/spaces_app_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/spaces_widget/space_post.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SpacesAppBar(),
          Expanded(
            child: ListView(
              children: const [
                SpacePost(
                  post: Post(
                    id: "1",
                    text:
                        "Man Utd is going to defeat chelsea i know this because Marcus Rashford is in incredible form, Sancho as gotten is rythm and confidence, bruno is just going to do bruno. However chelsea on the other are having an injury crisis.",
                    postUserInfo: {
                      "username": "iamlamide",
                    },
                    time: "1d",
                    comments: [
                      Comment(
                        time: "1hr",
                        comment:
                            "I totally agree with you, I'm a chelsea and i know we are about to be baked.",
                        likeCount: 4,
                        disLikeCount: 1,
                        commenter: {
                          "username": "johndoe",
                          "profileUrl": "",
                        },
                      ),
                    ],
                    likeCount: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
