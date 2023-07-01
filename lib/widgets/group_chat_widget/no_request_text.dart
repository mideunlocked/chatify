import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmptyListText extends StatelessWidget {
  const EmptyListText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white60,
          fontSize: 8.sp,
        ),
      ),
    );
  }
}
