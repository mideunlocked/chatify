import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widget/custom_back_button.dart';

class AppBarWide extends StatelessWidget {
  const AppBarWide({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // back button
          const Row(
            children: [
              CustomBackButton(),
            ],
          ),
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
