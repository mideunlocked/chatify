import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 7.sp,
        vertical: 2.sp,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 34, 53).withOpacity(0.3),
        border: Border.all(
          color: Colors.white10,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        autocorrect: true,
        maxLines: 5,
        minLines: 1,
        cursorColor: const Color.fromARGB(255, 192, 250, 223),
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Write your message",
        ),
        onChanged: (_) {},
        onEditingComplete: () {},
        onSubmitted: (value) {},
      ),
    );
  }
}
