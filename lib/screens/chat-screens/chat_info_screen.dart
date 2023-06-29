import 'package:chatify/widgets/general_widget/custom_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
                  const ChatInfoAppBar(),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.sp,
                      left: 70.sp,
                      bottom: 6.sp,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12.sp),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 192, 250, 223),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 34, 53),
                            fontSize: 11.sp,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color:
                                  allRead == true ? Colors.green : Colors.grey,
                              size: 5.sp,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                    Expanded(
                      child: ListView(
                        children: readBy.isEmpty
                            ? [
                                const Text(
                                  "No participant as read your message",
                                  textAlign: TextAlign.center,
                                ),
                              ]
                            : readBy.map((id) {
                                return FutureBuilder(
                                    future: cloudInstance
                                        .collection("users")
                                        .doc(id)
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      Map<String, dynamic>? data = snapshot.data
                                          ?.data() as Map<String, dynamic>?;

                                      return ReadByTile(
                                        username: data?["username"] ?? "xxxxx",
                                        divider: divider,
                                      );
                                    });
                              }).toList(),
                      ),
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

class ReadByTile extends StatelessWidget {
  const ReadByTile({
    super.key,
    required this.username,
    required this.divider,
  });

  final String username;
  final Divider divider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "@$username",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          divider,
        ],
      ),
    );
  }
}

class ChatInfoAppBar extends StatelessWidget {
  const ChatInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Row(
      children: [
        // back button
        const CustomBackButton(),

        SizedBox(
          width: 10.w,
        ),

        // title
        Text(
          "Message info",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
