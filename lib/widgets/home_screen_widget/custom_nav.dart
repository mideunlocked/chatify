import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'bottom_nav_icon.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          BottomNavIcon(
            iconUrl: "assets/icons/message.png",
            pageController: pageController,
            index: 0,
            currentIndex: currentIndex,
          ),
          // BottomNavIcon(
          //   iconUrl: "assets/icons/group-chat.png",
          //   pageController: pageController,
          //   index: 1,
          //   currentIndex: currentIndex,
          // ),
          BottomNavIcon(
            iconUrl: "assets/icons/communities.png",
            pageController: pageController,
            index: 2,
            currentIndex: currentIndex,
          ),
          BottomNavIcon(
            iconUrl: "assets/icons/search.png",
            pageController: pageController,
            index: 3,
            currentIndex: currentIndex,
          ),
          BottomNavIcon(
            iconUrl: "assets/icons/configure.png",
            pageController: pageController,
            index: 4,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}
