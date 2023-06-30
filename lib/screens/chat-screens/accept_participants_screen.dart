import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/group_chat_widget/chat_infor_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AcceptParticipantsScreen extends StatelessWidget {
  const AcceptParticipantsScreen(
      {super.key, required this.requests, required this.groupId});

  final List<dynamic> requests;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    var cloudInstance = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            children: [
              const ChatInfoAppBar(
                title: "Add participants",
              ),
              Expanded(
                child: ListView(
                  children: requests.map((id) {
                    return FutureBuilder(
                        future: cloudInstance.collection("users").doc(id).get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          Map<String, dynamic>? data =
                              snapshot.data?.data() as Map<String, dynamic>?;

                          return ListTile(
                            title: Text("@${data?["username"] ?? ""}"),
                            subtitle: Text(
                              data?["fullName"] ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white54,
                                  ),
                            ),
                            trailing: InkWell(
                              onTap: () => acceptRequest(
                                context,
                                groupId,
                                id,
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Colors.white,
                              ),
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
    );
  }

  void acceptRequest(
      BuildContext context, String groupId, String requestId) async {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    var result = await groupChatProvider.acceptRequest(groupId, requestId);
    // if ()
  }
}
