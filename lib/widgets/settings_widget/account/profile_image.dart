import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 50.sp,
            ),
          ],
        ),
        Positioned(
          left: 57.w,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 4, 255, 138),
            radius: 18.sp,
            child: Image.asset(
              "assets/icons/camera.png",
              color: const Color.fromARGB(255, 0, 34, 53),
              height: 7.h,
              width: 7.w,
            ),
          ),
        ),
      ],
    );
  }
}
