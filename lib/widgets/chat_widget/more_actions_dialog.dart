import 'dart:ui';

import 'package:chatify/providers/chatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MoreActionsDialog extends StatelessWidget {
  const MoreActionsDialog({
    super.key,
    required this.isMe,
    required this.text,
    required this.id,
    required this.time,
    required this.isRead,
    required this.date,
    required this.chatid,
    required this.recieverUsername,
  });

  final bool isMe;
  final String id;
  final String chatid;
  final bool isRead;
  final String time;
  final String date;
  final String text;
  final String recieverUsername;

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
                      ListTile(
                        onTap: () => replyChat(
                          isMe == true ? username ?? "" : recieverUsername,
                          text,
                          context,
                        ),
                        title: const Text(
                          "Reply",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.reply_rounded,
                          color: Colors.white,
                        ),
                      ),
                      isMe == true
                          ? ListTile(
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
                            )
                          : Container(),
                      ListTile(
                        onTap: () => deleteChat(context),
                        title: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
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

  // delete chat functions
  void deleteChat(context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.deleteMessage(
      id,
      chatid,
    );
    Navigator.pop(context);
  }
}
