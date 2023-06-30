import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/group_chat_widget/chat_info_bubble.dart';
import '../../widgets/group_chat_widget/chat_infor_app_bar.dart';
import '../../widgets/group_chat_widget/read_by_list_conatiner.dart';

class ChatInfoScreen extends StatelessWidget {
  const ChatInfoScreen({
    super.key,
    required this.text,
    required this.allRead,
    required this.readBy,
  });

  final String text;
  final bool allRead;
  final List<dynamic> readBy;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    const divider = Divider(
      color: Colors.white38,
    );
    FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 3.w,
              ),
              child: Column(
                children: [
                  const ChatInfoAppBar(
                    title: "Message info",
                  ),
                  ChatInfoBubble(text: text, allRead: allRead),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 5.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.teal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Read by",
                      style: of.textTheme.bodyLarge?.copyWith(
                        color: of.indicatorColor,
                      ),
                    ),
                    divider,
                    ReadByListContainer(
                      readBy: readBy,
                      cloudInstance: cloudInstance,
                      divider: divider,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
