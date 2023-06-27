import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/group_chat.dart';
import '../../providers/group_chatting.dart';
import '../../screens/group_messaging_screen.dart';
import 'unread_inidicator_widget.dart';

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

    var openImage = Image.asset(
      "assets/icons/global-network.png",
      color: Colors.blue,
      height: 10.sp,
      width: 10.sp,
    );
    var lockedImage = Image.asset(
      "assets/icons/lock.png",
      color: Colors.red,
      height: 10.sp,
      width: 10.sp,
    );

    var authInstance = FirebaseAuth.instance;
    var about = listGroupChat.about;
    var groupChatProvider = Provider.of<GroupChatting>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.w,
          ),
          child: FutureBuilder(
              future: groupChatProvider.getLastGCMessage(listGroupChat.id),
              builder: (context, snapshot) {
                Map<String, dynamic> data = snapshot.data ?? {};

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GroupMessagesScreen(),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 17.sp,
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
                    data["text"] ?? "xxxxxxxxxxx",
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
                          data["timeStamp"] ?? Timestamp.now(),
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
                          stream: groupChatProvider.getUnseenMessages(
                              listGroupChat.id, listGroupChat.recipients),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return 1.toString() == "0"
                                ? const Text("")
                                : UnreadIndicator(unreadCount: 1.toString());
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
