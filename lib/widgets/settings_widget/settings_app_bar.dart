import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
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
            "Settings",
            style: textTheme.bodyLarge,
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Logout"),
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      "assets/icons/exit.png",
                      height: 5.h,
                      width: 5.w,
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {}
            },
            child: Image.asset(
              "assets/icons/more.png",
              color: Colors.white,
              height: 8.h,
              width: 8.w,
            ),
          ),
        ],
      ),
    );
  }
}
