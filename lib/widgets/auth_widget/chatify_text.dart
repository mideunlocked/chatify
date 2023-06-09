import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatifyText extends StatelessWidget {
  const ChatifyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Text(
      "Chatify",
      style: textTheme.bodyLarge?.copyWith(
        fontSize: 15.sp,
        letterSpacing: 3.0,
        color: const Color.fromARGB(255, 192, 250, 223),
      ),
    );
  }
}
