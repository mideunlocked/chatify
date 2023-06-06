import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.iconUrl,
    required this.index,
    required this.pageController,
    required this.currentIndex,
  });

  final String iconUrl;
  final int index;
  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changePage(index, context),
      child: Image.asset(
        iconUrl,
        color: currentIndex == index
            ? const Color.fromARGB(255, 4, 255, 138)
            : Colors.white,
        height: 5.h,
        width: 5.h,
      ),
    );
  }

  // function to change page in bottom nav
  void changePage(int index, context) {
    pageController.jumpToPage(index);
  }
}
