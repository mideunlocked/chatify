import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
