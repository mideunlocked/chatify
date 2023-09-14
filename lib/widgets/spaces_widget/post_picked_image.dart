import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class PostPickedImage extends StatelessWidget {
  PostPickedImage({
    super.key,
    required this.postImage,
    required this.setState,
  });

  late File postImage;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.file(
          postImage,
          height: 8.h,
          width: 15.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              postImage.deleteSync();
            });
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
