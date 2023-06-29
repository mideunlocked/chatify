import 'dart:ui';

import 'package:chatify/providers/chatting.dart';
import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/screens/chat-screens/chat_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MoreActionsDialog extends StatelessWidget {
  const MoreActionsDialog({
    super.key,
    this.isGC =
        false, // this is to check if the dialog was called from a group chat
    required this.isMe,
    required this.text,
    required this.id,
    required this.time,
    required this.isRead,
    required this.date,
    required this.chatid,
    required this.recieverUsername,
    required this.readBy,
  });

  final bool isGC;
  final bool isMe;
  final String id;
  final String chatid;
  final bool isRead;
  final String time;
  final String date;
  final String text;
  final String recieverUsername;
  final List<dynamic> readBy;

  @override
  Widget build(BuildContext context) {
    String? username = FirebaseAuth.instance.currentUser?.displayName;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        splashColor: Colors.transparent,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 80.w,
                  margin: EdgeInsets.all(2.sp),
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: isMe == true
                        ? const Color.fromARGB(255, 192, 250, 223)
                        : const Color.fromARGB(255, 0, 34, 53),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe == true
                          ? const Color.fromARGB(255, 0, 34, 53)
                          : Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(7.sp),
                  padding: EdgeInsets.all(12.sp),
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 34, 53),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          time,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      textIconTile(
                        () => replyChat(
                          isMe == true ? username ?? "" : recieverUsername,
                          text,
                          context,
                        ),
                        "Reply",
                        Icons.reply_rounded,
                      ),
                      isMe == true
                          ? Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    "Read",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.circle_rounded,
                                    color: isMe == true
                                        ? isRead == true
                                            ? Colors.green
                                            : Colors.grey
                                        : Colors.transparent,
                                    size: 5.sp,
                                  ),
                                ),
                                textIconTile(
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => ChatInfoScreen(
                                        text: text,
                                        allRead: isRead,
                                        readBy: readBy,
                                      ),
                                    ),
                                  ),
                                  "Read by",
                                  Icons.info_rounded,
                                ),
                              ],
                            )
                          : Container(),
                      textIconTile(
                        () => isGC == false
                            ? deleteChat(context)
                            : deleteGCChat(context),
                        "Delete",
                        Icons.delete_rounded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile textIconTile(Function function, String title, IconData icon,
      {Color color = Colors.white}) {
    return ListTile(
      onTap: () {
        function();
      },
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        icon,
        color: color,
      ),
    );
  }

  // reply chat functions
  void replyChat(
    String name,
    String text,
    context,
  ) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.replyMessage(
      name,
      text,
    );
    Navigator.pop(context);
  }

  // delete personal chat function
  void deleteChat(context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.deleteMessage(
      id,
      chatid,
    );
    Navigator.pop(context);
  }

  // delete group chat function
  void deleteGCChat(context) {
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);

    groupChatProvider.deleteMessage(
      id,
      chatid,
    );
    Navigator.pop(context);
  }
}
