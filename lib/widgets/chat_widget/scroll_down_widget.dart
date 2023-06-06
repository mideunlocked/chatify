import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class ScrollDownWidget extends StatelessWidget {
  const ScrollDownWidget({
    super.key,
    required this.scrollController,
    required this.index,
  });

  final int index;
  final ItemScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: SizedBox(
        height: 3.h,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 34, 53),
          elevation: 10,
          onPressed: () {
            scrollController.scrollTo(
              index: index,
              duration: const Duration(milliseconds: 300),
            );
          },
          child: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }
}
