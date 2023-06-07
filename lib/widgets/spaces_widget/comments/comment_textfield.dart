import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
  });

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.w,
        right: 3.w,
        bottom: 2.h,
      ),
      child: TextField(
        controller: controller,
        cursorColor: const Color.fromARGB(255, 192, 250, 223),
        maxLines: 5,
        minLines: 1,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: const InputDecoration(
            hintText: "Enter your comment",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 192, 250, 223),
                width: 1.5,
              ),
            )),
        onSubmitted: (value) {},
      ),
    );
  }
}
