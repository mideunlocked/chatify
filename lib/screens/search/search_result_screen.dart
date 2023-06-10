import 'package:chatify/models/post.dart';
import 'package:chatify/models/users.dart';
import 'package:chatify/providers/post_provider.dart';
import 'package:chatify/providers/user_provider.dart';
import 'package:chatify/widgets/general_widget/custom_back_button.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:chatify/widgets/search_screen_widget/user_profile.dart';
import 'package:chatify/widgets/spaces_widget/space_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.searchText});

  final String searchText;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 2.w,
            right: 2.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomBackButton(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Showing results for '${widget.searchText}'",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Profiles",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: Colors.white60,
                        ),
                  ),
                ),
                FutureBuilder(
                    future: userProvider.searchUsers(),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.docs.where(
                        (element) =>
                            element["username"]
                                .toString()
                                .contains(widget.searchText) ||
                            element["fullName"]
                                .toString()
                                .contains(widget.searchText),
                      );
                      if (snapshot.hasError) {
                        return const Text(
                          "An error occured kindly contact the developer",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        );
                      }

                      if (snapshot.hasData != true) {
                        return const Text("");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomProgressIndicator();
                      }

                      return SizedBox(
                        width: 100.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: data?.isEmpty == true
                                ? [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No profile matching '${widget.searchText}'",
                                        style: const TextStyle(
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                  ]
                                : data?.map((result) {
                                      return ProfileCard(
                                        user: Users(
                                          id: result.id,
                                          fullName: result["fullName"] ?? "",
                                          username: result["username"] ?? "",
                                          email: result["email"] ?? "",
                                          phoneNumber:
                                              result["phoneNumber"] ?? "",
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                          ),
                        ),
                      );
                    }),
                const Divider(
                  color: Colors.white30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Space conversations",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: Colors.white60,
                        ),
                  ),
                ),
                FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: postProvider.searchPost(widget.searchText),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.docs.where(
                        (element) =>
                            element["text"]
                                .toString()
                                .contains(widget.searchText) ||
                            element["postUserInfo"]["username"]
                                .toString()
                                .contains(widget.searchText),
                      );
                      if (snapshot.hasError) {
                        return const Text(
                          "An error occured kindly contact the developer",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        );
                      }

                      if (snapshot.hasData != true) {
                        return const Text("");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomProgressIndicator();
                      }

                      return Column(
                        children: data?.isEmpty == true
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No conversation matching '${widget.searchText}'",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              ]
                            : data
                                    ?.map(
                                      (result) => SpacePost(
                                        post: Post(
                                          id: result.id,
                                          text: result["text"] ?? "",
                                          postUserInfo:
                                              result["postUserInfo"] ?? {},
                                          time:
                                              result["time"] ?? Timestamp.now(),
                                          likeCount: result["likes"] ?? [],
                                        ),
                                        index: 0,
                                      ),
                                    )
                                    .toList() ??
                                [],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
