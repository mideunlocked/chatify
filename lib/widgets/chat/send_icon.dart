import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SendIcon extends StatelessWidget {
  const SendIcon({
    super.key,
    required this.function,
  });

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
          width: 12.w,
          height: 12.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 192, 250, 223),
          ),
          child: Image.asset(
            "assets/icons/share.png",
            height: 7.h,
            width: 7.w,
          )),
    );
  }
}
