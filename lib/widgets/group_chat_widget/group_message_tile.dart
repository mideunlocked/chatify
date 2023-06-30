import 'package:chatify/screens/chat-screens/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../helpers/gc_status.dart';
import '../../models/group_chat.dart';
import '../../providers/group_chatting.dart';
import '../message_list/unread_inidicator_widget.dart';

class GroupMessageTile extends StatelessWidget {
  const GroupMessageTile({
    super.key,
    required this.listGroupChat,
  });

  final ListGroupChat listGroupChat;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var about = listGroupChat.about;
    var groupChatProvider = Provider.of<GroupChatting>(context);
    int totalCount = 0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.w,
          ),
          child: StreamBuilder(
              stream: groupChatProvider.getMessages(listGroupChat.id),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var data = snapshot.data?.docs.first;
                totalCount = snapshot.data?.size ?? 0;

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupChatScreen(
                          groupChat: ListGroupChat(
                            id: listGroupChat.id,
                            about: about,
                            recipients: listGroupChat.recipients,
                            admins: listGroupChat.admins,
                            timestamp: listGroupChat.timestamp,
                            requests: listGroupChat.requests,
                            chats: snapshot.data?.docs
                                    .map(
                                      (DocumentSnapshot e) => GroupChat(
                                        id: e.id,
                                        senderId: e["senderId"] ?? "",
                                        timeStamp:
                                            e["timeStamp"] ?? Timestamp.now(),
                                        reply: e["reply"] ?? {},
                                        isSeen: e["isSeen"] ?? [],
                                        isSent: e["isSent"] ?? false,
                                        text: e["text"] ?? "",
                                      ),
                                    )
                                    .toList() ??
                                [],
                          ),
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 17.sp,
                    backgroundImage:
                        const AssetImage("assets/images/logo-2.png"),
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
                        about["isPublic"] == true ? openImage : lockedImage,
                      ],
                    ),
                  ),
                  subtitle: Text(
                    data?["text"] ?? "xxxxxxxxxxx",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color.fromARGB(255, 192, 250, 223),
                      fontSize: 10.sp,
                    ),
                  ),
                  trailing: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // time widget
                      Text(
                        DateTimeFormatting().timeAgo(
                          data?["timeStamp"] ?? Timestamp.now(),
                        ),
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 9.sp,
                        ),
                      ),

                      // space
                      SizedBox(
                        height: 5.sp,
                      ),

                      // unread message indicator
                      StreamBuilder(
                          stream: groupChatProvider
                              .getUnseenMessages(listGroupChat.id),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            int size = snapshot.data?.size ?? 0;
                            int unreadCount = totalCount - size;

                            return unreadCount.toString() == "0"
                                ? const Text("")
                                : UnreadIndicator(
                                    unreadCount: unreadCount.toString());
                          }),
                    ],
                  ),
                );
              }),
        ),

        // divider for seperation
        const Divider(
          color: Colors.white12,
          thickness: 0.5,
        ),
      ],
    );
  }
}
