import 'package:chatify/models/post.dart';
import 'package:chatify/providers/post_provider.dart';
import 'package:chatify/widgets/spaces_widget/spaces_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/spaces_widget/space_post.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          const SpacesAppBar(),
          Expanded(
            child: StreamBuilder(
                stream: postProvider.getPosts(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text("Loading");
                  } else if (snapshot.hasData == false) {
                    return const Text("No data");
                  }
                  return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot postData) {
                    Map<String, dynamic> post =
                        postData.data()! as Map<String, dynamic>;
                    print(post["likeCount"]);

                    return SpacePost(
                      post: Post(
                        id: postData.id,
                        text: post["text"] ?? "",
                        postUserInfo: post["postUserInfo"] ?? {},
                        time: post["time"] ?? Timestamp.now(),
                        likeCount: post["likes"] ?? [],
                      ),
                      index: 0,
                    );
                  }).toList());
                }),
          ),
        ],
      ),
    );
  }
}
