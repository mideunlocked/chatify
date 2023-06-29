import 'package:chatify/helpers/date_time_formatting.dart';
import 'package:chatify/models/users.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/screens/chat-screens/chat_screen.dart';
import 'package:chatify/widgets/message_list/unread_inidicator_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({
    super.key,
    required this.recieverUid,
    required this.chatId,
  });

  final String recieverUid;
  final String chatId;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  Users? user;

  @override
  void initState() {
    super.initState();

    getReciever();
    print("Reciver username: ${user?.username}");
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var chattingProvider = Provider.of<Chatting>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.w,
          ),
          child: FutureBuilder(
              future: chattingProvider.getLastMessageDetails(widget.chatId),
              builder: (context, snapshot) {
                Map<String, dynamic> data = snapshot.data ?? {};

                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        user: Users(
                          id: user?.id ?? "",
                          fullName: user?.fullName ?? "",
                          username: user?.username ?? "",
                          email: user?.email ?? "",
                          phoneNumber: user?.phoneNumber ?? "",
                        ),
                        chatId: widget.chatId,
                        recieverId: widget.recieverUid,
                      ),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 17.sp,
                  ),
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: Row(
                      children: [
                        Text(
                          user?.username ?? "",
                          style: textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        user?.username == "chatify"
                            ? const Icon(
                                Icons.verified_rounded,
                                color: Colors.amber,
                              )
                            : Container(),
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
                          stream: chattingProvider.getUnseenMessages(
                              widget.chatId, widget.recieverUid),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            String? unreadCount =
                                snapshot.data?.size.toString();

                            return unreadCount == "0"
                                ? const Text("")
                                : UnreadIndicator(unreadCount: unreadCount);
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

  Future<void> getReciever() async {
    FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

    try {
      var data =
          await cloudInstance.collection("users").doc(widget.recieverUid).get();
      Map<String, dynamic>? userData = data.data();

      setState(() {
        user = Users(
          id: userData?["id"] ?? "",
          fullName: userData?["fullName"] ?? "",
          username: userData?["username"] ?? "",
          email: userData?["email"] ?? "",
          phoneNumber: userData?["phoneNumber"] ?? "",
        );
      });
    } catch (error) {
      print("Get reciever data: $error");
    }
  }
}
