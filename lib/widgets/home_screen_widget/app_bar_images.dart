import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBarIcon extends StatelessWidget {
  AppBarIcon({
    super.key,
    required this.url,
    this.color = Colors.white,
    required this.function,
    double? height,
    double? width,
  })  : height = height ?? 5.h,
        width = width ?? 5.w;

  final String url;
  final Color color;
  final double height;
  final double width;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function,
      child: Image.asset(
        url,
        color: Colors.white,
        height: 8.h,
        width: 8.w,
      ),
    );
  }
}
