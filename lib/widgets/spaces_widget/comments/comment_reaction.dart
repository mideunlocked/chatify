import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommentReaction extends StatelessWidget {
  const CommentReaction({
    super.key,
    required this.count,
    required this.icon,
    required this.icon2,
    this.isActive = false,
    required this.toggleLike,
  });

  final String count;
  final bool isActive;
  final Function toggleLike;
  final IconData icon, icon2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleLike();
      },
      child: Column(
        children: [
          Icon(
            isActive == true ? icon2 : icon,
            color: Colors.white60,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            count,
            style: const TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
