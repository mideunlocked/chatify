import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.fucntion,
    required this.isLoading,
  });

  final String text;
  final bool isLoading;
  final Function fucntion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fucntion();
      },
      child: Container(
        height: 7.h,
        width: 80.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: text == "Login"
              ? const Color.fromARGB(255, 192, 250, 223)
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color.fromARGB(255, 192, 250, 223).withOpacity(0.5),
          ),
        ),
        child: isLoading == true
            ? const CustomProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color:
                      text == "Login" ? Theme.of(context).primaryColor : null,
                ),
              ),
      ),
    );
  }
}
