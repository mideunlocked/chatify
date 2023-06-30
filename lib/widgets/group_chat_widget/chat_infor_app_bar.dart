import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widget/custom_back_button.dart';

class ChatInfoAppBar extends StatelessWidget {
  const ChatInfoAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Row(
      children: [
        // back button
        const CustomBackButton(),

        SizedBox(
          width: 10.w,
        ),

        // title
        Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
