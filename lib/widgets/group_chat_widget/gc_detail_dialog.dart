import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/screens/chat-screens/accept_participants_screen.dart';
import 'package:chatify/screens/chat-screens/remove_participants_screen.dart';
import 'package:chatify/screens/home_screen.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../helpers/gc_status.dart';
import 'detail_action_button.dart';
import 'future_username_text.dart';

class GCDetailsDialog extends StatefulWidget {
  const GCDetailsDialog({
    super.key,
    required this.about,
    required this.admins,
    required this.participants,
    required this.reuqests,
    required this.groupId,
  });

  final Map<String, dynamic> about;
  final List<dynamic> admins;
  final List<dynamic> reuqests;
  final List<dynamic> participants;
  final String groupId;

  @override
  State<GCDetailsDialog> createState() => _GCDetailsDialogState();
}

class _GCDetailsDialogState extends State<GCDetailsDialog> {
  bool isLeaving = false;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    var textStyle = const TextStyle(
      color: Colors.white60,
    );
    var dateTime = DateTimeFormatting().formatTimeDate(
      widget.about["createdOn"] ?? Timestamp.now(),
    );
    var sizedBox = SizedBox(
      height: 1.h,
    );
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Dialog(
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 50.h,
        width: 80.w,
        child: isLeaving == true
            ? const CustomProgressIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 3.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/logo-2.png",
                        height: 10.h,
                        width: 22.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.about["name"] ?? "",
                          style: textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        widget.about["isPublic"] == true
                            ? openImage
                            : lockedImage,
                      ],
                    ),
                    sizedBox,
                    Text(
                      widget.about["description"] ?? "",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "${widget.participants.length} participants",
                      style: textStyle,
                    ),
                    FutureUsernameText(
                      uid: widget.admins.first ?? "",
                      textStyle: textStyle,
                      keyString: "Admin",
                    ),
                    FutureUsernameText(
                      uid: widget.about["createdBy"] ?? "",
                      textStyle: textStyle,
                      keyString: "Created by",
                    ),
                    Text(
                      "Created on: ${dateTime[1]}",
                      style: textStyle,
                    ),
                    sizedBox,
                    widget.admins.contains(uid)
                        ? Row(
                            children: [
                              DetailActionButton(
                                color: Colors.red,
                                text: """Remove 
participant""",
                                function: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => RemoveParticipantsScreen(
                                      participants: widget.participants,
                                      admins: widget.admins,
                                      groupId: widget.groupId,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              DetailActionButton(
                                color: Colors.green,
                                text: """Add 
participant""",
                                function: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => AcceptParticipantsScreen(
                                      requests: widget.reuqests,
                                      groupId: widget.groupId,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : DetailActionButton(
                            text: "Exit group",
                            color: Colors.red,
                            function: () => exitGroup(context),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> exitGroup(BuildContext context) async {
    setState(() {
      isLeaving = true;
    });
    var groupChatProvider = Provider.of<GroupChatting>(context, listen: false);
    String? uid = groupChatProvider.authInstance.currentUser?.uid;

    var result = await groupChatProvider.removeParticipants(
      widget.groupId,
      uid ?? "",
    );

    if (result == true) {
      setState(() {
        isLeaving = false;
      });
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      } else {
        setState(() {
          isLeaving = false;
        });
      }
    }
  }
}
