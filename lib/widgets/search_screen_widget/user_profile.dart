import 'package:chatify/models/users.dart';
import 'package:chatify/screens/chat-screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth authInstance = FirebaseAuth.instance;
    String? uid = authInstance.currentUser?.uid;
    print(user.id);

    return GestureDetector(
      onTap: () => uid == user.id
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ChatScreen(
                  user: user,
                  chatId: "",
                  recieverId: user.id,
                ),
              ),
            ),
      child: Card(
        color: const Color.fromARGB(255, 0, 34, 53),
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40.sp,
                backgroundColor: Colors.white38,
              ),
              SizedBox(
                height: 1.h,
              ),
              Column(
                children: [
                  Text(user.fullName),
                  Row(
                    children: [
                      Text(
                        "@${user.username}",
                        style: const TextStyle(color: Colors.white38),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      user.username == "chatify"
                          ? const Icon(
                              Icons.verified_rounded,
                              color: Colors.amber,
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
