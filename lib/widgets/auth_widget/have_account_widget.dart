import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
    required this.checkText,
    required this.actionText,
    required this.widget,
  });

  final String checkText;
  final String actionText;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    const color2 = Color.fromARGB(255, 192, 250, 223);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 4.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$checkText ?  "),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => widget,
              ),
            ),
            child: Text(
              actionText,
              style: const TextStyle(
                color: color2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
