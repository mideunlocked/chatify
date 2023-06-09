import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'chatify_text.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    super.key,
    this.title = "",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color.fromARGB(255, 192, 250, 223),
                ),
              ),
            ],
          ),
          ChatifyText(title: title),
        ],
      ),
    );
  }
}
