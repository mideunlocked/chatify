import 'dart:ui';

import 'package:chatify/providers/chatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MoreActionsDialog extends StatelessWidget {
  const MoreActionsDialog({
    super.key,
    required this.isMe,
    required this.text,
    required this.id,
  });

  final bool isMe;
  final String id;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        splashColor: Colors.transparent,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 34, 53),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        "08:20 pm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
                                trailing: Container(
                                  height: 10.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isMe == true
                                        ? Colors.green
                                        : Colors.transparent,
                                  ),
                                  child: const Text(" "),
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "Delivered",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Container(
                                  height: 10.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isMe == true
                                        ? Colors.green
                                        : Colors.transparent,
                                  ),
                                  child: const Text(" "),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    ListTile(
                      onTap: () => replyData(
                          isMe == true ? "You" : "Uber Driver", text, context),
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
    );
  }

  void replyData(String name, String text, context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.replyMessage(name, text);
    Navigator.pop(context);
  }

  void deleteChat(context) {
    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    chattingProvider.deleteMessage(id);
    Navigator.pop(context);
  }
}
