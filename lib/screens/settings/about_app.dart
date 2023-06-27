import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings_widget/about_app/licenses_button.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      color: Colors.white38,
    );
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo-1.png",
              width: 90,
              height: 90,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Chatify",
            style: textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w900, fontSize: 40.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "Version 1.2.1",
            style: textStyle,
          ),
          Text(
            "© 2023 Stact Platforms Inc.",
            style: textStyle,
          ),
          const LicensesButton(),
        ],
      ),
    );
  }
}
