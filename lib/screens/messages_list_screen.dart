import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 12.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    "assets/images/share.png",
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const ChatTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.w,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 17.sp,
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Text(
                "Uber Driver",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Text(
              "I'm on my way to you now",
              style: TextStyle(
                color: Color.fromARGB(255, 192, 250, 223),
              ),
            ),
            trailing: Stack(
              alignment: Alignment.topRight,
              children: [
                Text(
                  "02:30 pm",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                  height: 5.h,
                  width: 5.w,
                  margin: EdgeInsets.only(top: 10.sp),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 192, 250, 223),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 34, 53),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.white12,
          thickness: 0.5,
        ),
      ],
    );
  }
}
