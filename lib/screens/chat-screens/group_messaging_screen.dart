import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/group_chat.dart';
import '../../providers/group_chatting.dart';
import '../../widgets/group_chat_widget/group_message_tile.dart';
import '../../widgets/message_list/message_app_bar.dart';

class GroupMessagesScreen extends StatefulWidget {
  const GroupMessagesScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

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
          AnimatedBuilder(
            animation: widget.scrollController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: widget.scrollController.hasClients &&
                        widget.scrollController.position.userScrollDirection ==
                            ScrollDirection.reverse
                    ? 0
                    : 10.h,
                child: child,
              );
            },
            child: const MessagesAppBar(
              title: "Group messages",
            ),
          ),

          // messages list
          Expanded(
            child: StreamBuilder(
                stream: groupChatProvider.getUserGCMessageList(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    controller: widget.scrollController,
                    physics: const BouncingScrollPhysics(),
                    children: snapshot.data?.docs
                            .map((DocumentSnapshot gCListData) {
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

                          Map<String, dynamic> gChat =
                              gCListData.data()! as Map<String, dynamic>;
                          return GroupMessageTile(
                            listGroupChat: ListGroupChat(
                              id: gCListData.id,
                              about: gChat["about"] ?? {},
                              recipients: gChat["recipients"] ?? [],
                              chats: [],
                              admins: gChat["admins"] ?? {},
                              requests: gChat["requests"] ?? [],
                              timestamp: gChat["timeStamp"] ?? Timestamp.now(),
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
