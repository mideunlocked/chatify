import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailActionButton extends StatelessWidget {
  const DetailActionButton({
    super.key,
    required this.text,
    required this.color,
    required this.function,
  });

  final String text;
  final Color color;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: FloatingActionButton.extended(
        backgroundColor: color,
        onPressed: () {
          function();
        },
        label: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8.sp,
          ),
        ),
      ),
    );
  }
}
