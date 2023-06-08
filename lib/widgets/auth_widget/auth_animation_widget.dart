import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AuthAnimationWidget extends StatelessWidget {
  const AuthAnimationWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        url,
        height: 30.h,
        width: 50.w,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            "assets/images/logo-1.png",
            height: 50.h,
            width: 80.w,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
