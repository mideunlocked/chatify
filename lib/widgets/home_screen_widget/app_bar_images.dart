import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBarIcon extends StatelessWidget {
  AppBarIcon({
    super.key,
    required this.url,
    this.color = Colors.white,
    double? height,
    double? width,
  })  : height = height ?? 5.h,
        width = width ?? 5.w;

  final String url;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      color: Colors.white,
      height: height,
      width: width,
    );
  }
}
