import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/group_chat.dart';
import '../providers/group_chatting.dart';
import '../widgets/message_list/group_message_tile.dart';
import '../widgets/message_list/message_app_bar.dart';

class GroupMessagesScreen extends StatefulWidget {
  const GroupMessagesScreen({super.key});

  @override
  State<GroupMessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<GroupMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var groupChatProvider = Provider.of<GroupChatting>(context);

    return SafeArea(
      child: Column(
        children: [
          // custom app bar
          const MessagesAppBar(
            title: "Group messages",
          ),

          // messages list
          Expanded(
            child: StreamBuilder(
                stream: groupChatProvider.getUserGCMessageList(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: snapshot.data?.docs
                            .map((DocumentSnapshot GCListData) {
                          if (snapshot.hasData) {
                            print("Has data");
                          }
                          if (snapshot.hasError) {
                            print("Has error");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print("Loading");
                          }

                          // print(snapshot.data?.size);
                          // String? uid = FirebaseAuth.instance.currentUser?.uid;
                          Map<String, dynamic> GChat =
                              GCListData.data()! as Map<String, dynamic>;
                          // List<dynamic> recieverId =
                          // GChat["recipients"] as List<dynamic>;
                          // recieverId.removeWhere((value) => value == uid);
                          // print(recieverId[0] + "   fghj");
                          return GroupMessageTile(
                            listGroupChat: ListGroupChat(
                              id: GCListData.id,
                              about: GChat["about"] ?? {},
                              recipients: GChat["recipients"] ?? [],
                              chats: [],
                              admins: GChat["admins"] ?? {},
                              timestamp: GChat["timeStamp"] ?? Timestamp.now(),
                            ),
                          );
                        }).toList() ??
                        [],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
