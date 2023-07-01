import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/group_chat_widget/chat_infor_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/group_chat_widget/no_request_text.dart';
import '../../widgets/group_chat_widget/participant_action_list_tile.dart';

class RemoveParticipantsScreen extends StatefulWidget {
  const RemoveParticipantsScreen(
      {super.key,
      required this.participants,
      required this.groupId,
      required this.admins});

  final List<dynamic> participants;
  final List<dynamic> admins;
  final String groupId;

  @override
  State<RemoveParticipantsScreen> createState() =>
      _AcceptParticipantsScreenState();
}

class _AcceptParticipantsScreenState extends State<RemoveParticipantsScreen> {
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
                  title: "Remove participants",
                ),
                Expanded(
                  child: widget.participants.isEmpty
                      ? const EmptyListText(
                          text:
                              "Oops! It seems like there are no participants in this group yet. Don't worry, invite your friends and start engaging in conversations!",
                        )
                      : ListView(
                          children: widget.participants.map((id) {
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
                                    admins: widget.admins,
                                    icon: Icons.person_remove_alt_1_rounded,
                                    iconColor: Colors.red,
                                    function: () => removeParticipant(
                                      context,
                                      widget.groupId,
                                      id,
                                      data?["username"] ?? "",
                                    ),
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

  void removeParticipant(BuildContext context, String groupId, String requestId,
      String username) async {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    var result = await groupChatProvider.removeParticipants(groupId, requestId);
    if (result == true) {
      setState(() {
        widget.participants.remove(requestId);
      });
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Removed $username from group"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
