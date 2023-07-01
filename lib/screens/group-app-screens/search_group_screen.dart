import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/search_screen_widget/no_search_result_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/gc_status.dart';
import '../../widgets/general_widget/custom_progress_indicator.dart';
import '../../widgets/search_screen_widget/search_app_bar.dart';

class SearchGroupScreen extends StatefulWidget {
  const SearchGroupScreen({super.key});

  @override
  State<SearchGroupScreen> createState() => _SearchGroupScreenState();
}

class _SearchGroupScreenState extends State<SearchGroupScreen> {
  final controller = TextEditingController();
  Future<QuerySnapshot<Map<String, dynamic>>>? querySnapshot;

  @override
  Widget build(BuildContext context) {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              controller: controller,
              function: () {
                setState(() {
                  querySnapshot = groupChatProvider.searchGroups(
                    controller.text.trim(),
                  );
                });
              },
            ),
            controller.text.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: const Text(
                      "Try searching for a group",
                      style: TextStyle(color: Colors.white60),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: querySnapshot,
                        builder: (context, snapshot) {
                          var searchText = controller.text.trim();

                          var data = snapshot.data?.docs.where(
                            (element) => element["about"]["name"]
                                .toString()
                                .toLowerCase()
                                .contains(
                                  searchText.toLowerCase(),
                                ),
                          );

                          if (snapshot.hasError) {
                            return const Text(
                              "An error occured kindly contact the developer",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white54),
                            );
                          }

                          if (snapshot.hasData != true) {
                            return NoSearchResultText(
                                text: "No group matching '$searchText'");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomProgressIndicator();
                          }

                          return ListView(
                            children: data?.isEmpty == true
                                ? [
                                    NoSearchResultText(
                                      text: "No group matching '$searchText'",
                                    ),
                                  ]
                                : data
                                        ?.map(
                                          (result) => SearchGroupTile(
                                            result: result,
                                          ),
                                        )
                                        .toList() ??
                                    [],
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}

class SearchGroupTile extends StatefulWidget {
  const SearchGroupTile({
    super.key,
    required this.result,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> result;

  @override
  State<SearchGroupTile> createState() => _SearchGroupTileState();
}

class _SearchGroupTileState extends State<SearchGroupTile> {
  bool isPaticipant = false;
  bool isLoading = false;
  bool isRequested = false;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var groupId = widget.result["id"];
    var about = widget.result["about"];
    bool isPublic = about["isPublic"];
    List<dynamic> recipients = widget.result["recipients"] ?? [];
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    isPaticipant = recipients.contains(uid);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 17.sp,
              backgroundImage: const AssetImage("assets/images/logo-2.png"),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Row(
                children: [
                  Text(
                    about["name"] ?? "",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  isPublic == true ? openImage : lockedImage,
                ],
              ),
            ),
            subtitle: Text(
              about["description"] ?? "xxxxxxxxxxx",
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white60,
                fontSize: 10.sp,
              ),
            ),
            trailing: isLoading == true
                ? const CircularProgressIndicator(
                    strokeWidth: 1.0,
                    color: Color.fromARGB(255, 0, 187, 6),
                  )
                : isPaticipant
                    ? const Icon(
                        Icons.check_circle_sharp,
                        color: Colors.grey,
                      )
                    : isPublic == true
                        ? JoinGroupButton(
                            color: Colors.green,
                            text: "Join",
                            tag: "1",
                            function: () => joinGroup(context, groupId),
                          )
                        : JoinGroupButton(
                            color:
                                isRequested == true ? Colors.grey : Colors.blue,
                            text: isRequested == true ? "Requested" : "Request",
                            tag: "2",
                            function: () => requestGroup(context, groupId),
                          ),
          ),
          const Divider(
            color: Colors.white10,
          ),
        ],
      ),
    );
  }

  void joinGroup(BuildContext context, String groupId) async {
    setState(() {
      isLoading = true;
    });
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    var result = await groupChatProvider.joinGroup(groupId);

    if (result == true) {
      setState(() {
        isPaticipant = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void requestGroup(BuildContext context, String groupId) async {
    setState(() {
      isLoading = true;
    });
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    var result = await groupChatProvider.requestJoinGroup(groupId);

    if (result == true) {
      setState(() {
        isRequested = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}

class JoinGroupButton extends StatelessWidget {
  const JoinGroupButton({
    super.key,
    required this.text,
    required this.color,
    required this.tag,
    required this.function,
  });

  final Function function;
  final String text;
  final Color color;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: tag,
      onPressed: () {
        function();
      },
      label: Text(
        text,
      ),
      backgroundColor: color,
    );
  }
}
