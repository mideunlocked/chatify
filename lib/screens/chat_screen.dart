import 'package:chatify/providers/chatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/chat/app_bar.dart';
import '../widgets/chat/bubble.dart';
import '../widgets/chat/scroll_down_widget.dart';
import '../widgets/chat/text_input_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final itemScrollController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();
  int? lastIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chattingProvider = Provider.of<Chatting>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            const ChatScreenAppBar(),

            // chat's widget
            Expanded(
              child: ScrollablePositionedList.builder(
                  physics: const BouncingScrollPhysics(),
                  itemScrollController: itemScrollController,
                  itemCount: chattingProvider.chats.length,
                  itemPositionsListener: itemListener,
                  itemBuilder: (context, index) {
                    var chat = chattingProvider.chats;
                    itemListener.itemPositions.addListener(() {
                      lastIndex = itemListener.itemPositions.value.last.index;
                      print(lastIndex);
                    });

                    return ChatBubble(
                      text: chat[index].text,
                      isMe: chat[index].isMe,
                      isRead: chat[index].isSeen,
                      id: chat[index].id,
                      reply: chat[index].reply,
                      index: index,
                      scrollController: itemScrollController,
                    );
                  }),
            ),

            // Text input widget
            TextInputWidget(
              replyText: chattingProvider.reply["text"] ?? "",
              name: chattingProvider.reply["name"] ?? "",
              index: chattingProvider.reply["index"] ?? 0,
              isMe: true,
            ),
          ],
        ),
      ),

      // scroll down widget
      floatingActionButton: ScrollDownWidget(
        index: lastIndex ?? 0,
        scrollController: itemScrollController,
      ),
    );
  }
}
