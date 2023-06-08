import 'dart:ui';

import 'package:chatify/widgets/home_screen_widget/app_bar_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'post_bottomsheet.dart';

class SpacesAppBar extends StatelessWidget {
  const SpacesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    const radius = Radius.circular(35);

    return Container(
      height: 8.h,
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
            "Spaces",
            style: textTheme.bodyLarge,
          ),
          GestureDetector(
            onTap: () => postSpaceConversation(context),
            child: AppBarIcon(
              url: "assets/icons/plus.png",
            ),
          ),
        ],
      ),
    );
  }

  void postSpaceConversation(BuildContext context) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: const PostBottomsheet());
      },
    );
  }
}
