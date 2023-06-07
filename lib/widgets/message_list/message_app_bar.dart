import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../home_screen_widget/app_bar_images.dart';

class MessagesAppBar extends StatelessWidget {
  const MessagesAppBar({
    super.key,
    required this.title,
  });

  final String title;

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
            title,
            style: textTheme.bodyLarge,
          ),
          const Spacer(),
          Row(
            children: [
              AppBarIcon(
                url: "assets/icons/search.png",
              ),
              title.contains("Group") != true
                  ? Container()
                  : Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        AppBarIcon(
                          url: "assets/icons/plus.png",
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
