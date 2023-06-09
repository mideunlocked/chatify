import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/group_chat_widget/chat_infor_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/group_chat_widget/no_request_text.dart';
import '../../widgets/group_chat_widget/participant_action_list_tile.dart';

class AcceptParticipantsScreen extends StatefulWidget {
  const AcceptParticipantsScreen(
      {super.key, required this.requests, required this.groupId});

  final List<dynamic> requests;
  final String groupId;

  @override
  State<AcceptParticipantsScreen> createState() =>
      _AcceptParticipantsScreenState();
}

class _AcceptParticipantsScreenState extends State<AcceptParticipantsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var cloudInstance = FirebaseFirestore.instance;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Column(
              children: [
                const ChatInfoAppBar(
                  title: "Add participants",
                ),
                Expanded(
                  child: widget.requests.isEmpty
                      ? const EmptyListText(
                          text:
                              "Looks like there are no requests at the moment",
                        )
                      : ListView(
                          children: widget.requests.map((id) {
                            return FutureBuilder(
                                future: cloudInstance
                                    .collection("users")
                                    .doc(id)
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  Map<String, dynamic>? data = snapshot.data
                                      ?.data() as Map<String, dynamic>?;

                                  return ParticipantActionListTile(
                                    data: data,
                                    admins: const [],
                                    function: () => acceptRequest(
                                      context,
                                      widget.groupId,
                                      id,
                                      data?["username"] ?? "",
                                    ),
                                    icon: Icons.person_add_alt_1_rounded,
                                    iconColor: Colors.green,
                                  );
                                });
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void acceptRequest(BuildContext context, String groupId, String requestId,
      String username) async {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    var result = await groupChatProvider.acceptRequest(groupId, requestId);
    if (result == true) {
      setState(() {
        widget.requests.remove(requestId);
      });
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Added $username to group"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
