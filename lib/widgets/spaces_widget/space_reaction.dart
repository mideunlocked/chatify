import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpaceReaction extends StatelessWidget {
  const SpaceReaction({
    super.key,
    required this.count,
    required this.icon,
    required this.function,
    required this.icon2,
  });

  final String count;
  final IconData icon, icon2;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function,
      child: Column(
        children: [
          Icon(
            icon,
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
