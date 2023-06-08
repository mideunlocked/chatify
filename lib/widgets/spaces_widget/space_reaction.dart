import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpaceReaction extends StatelessWidget {
  const SpaceReaction({
    super.key,
    required this.count,
    required this.icon,
    required this.icon2,
    this.isActive = false,
  });

  final String count;
  final bool isActive;
  final IconData icon, icon2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isActive == true ? icon2 : icon,
          color: isActive == true
              ? const Color.fromARGB(255, 255, 17, 0)
              : Colors.white60,
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          count,
          style: const TextStyle(color: Colors.white60),
        ),
      ],
    );
  }
}
