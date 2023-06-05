import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessagesAppBar extends StatelessWidget {
  const MessagesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    const radius = Radius.circular(35);

    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Messages",
            style: textTheme.bodyLarge,
          ),
          Image.asset(
            "assets/images/search.png",
            color: Colors.white,
            height: 7.h,
            width: 7.w,
          ),
        ],
      ),
    );
  }
}
