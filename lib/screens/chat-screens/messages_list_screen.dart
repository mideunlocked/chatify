import 'package:chatify/providers/chatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/message_list/message_app_bar.dart';
import '../../widgets/message_list/message_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<Chatting>(context);

    return SafeArea(
      child: Column(
        children: [
          // custom app bar
          AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: scrollController.hasClients &&
                        scrollController.position.userScrollDirection ==
                            ScrollDirection.reverse
                    ? 0
                    : 10.h,
                child: child,
              );
            },
            child: const MessagesAppBar(
              title: "Messages",
            ),
          ),

          // messages list
          Expanded(
            child: StreamBuilder(
                stream: chatProvider.getUserMessageList(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    children:
                        snapshot.data?.docs.map((DocumentSnapshot listData) {
                              String? uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              Map<String, dynamic> chat =
                                  listData.data()! as Map<String, dynamic>;
                              List<dynamic> recieverId =
                                  chat["recipients"] as List<dynamic>;
                              recieverId.removeWhere((value) => value == uid);
                              print(recieverId[0] + "   fghj");

                              return MessageTile(
                                chatId: listData.id,
                                recieverUid: recieverId[0] ?? "",
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
