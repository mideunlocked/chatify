import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PostCommentMoreWidget extends StatelessWidget {
  const PostCommentMoreWidget({
    super.key,
    required this.moreFunction,
  });

  final Function moreFunction;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Delete"),
              SizedBox(
                width: 3.w,
              ),
              const Icon(
                Icons.delete_rounded,
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          moreFunction();
        }
      },
      child: Image.asset(
        "assets/icons/more.png",
        color: Colors.white60,
        height: 3.h,
        width: 3.w,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
