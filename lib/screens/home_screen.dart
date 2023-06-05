import 'package:chatify/screens/messages_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const MessagesScreen(),
          Container(
            height: 6.h,
            width: 100.w,
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.list_rounded,
                  color: Colors.white,
                ),
                Icon(
                  Icons.group_rounded,
                  color: Colors.white,
                ),
                Image.asset(
                  "assets/images/search.png",
                  color: Colors.white,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
