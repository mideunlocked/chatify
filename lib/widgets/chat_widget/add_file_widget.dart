// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:chatify/widgets/spaces_widget/post_picked_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddFileWidget extends StatefulWidget {
  AddFileWidget({
    super.key,
    required this.callback,
    required this.file,
  });

  final Function(File) callback;
  late File file;

  @override
  State<AddFileWidget> createState() => _AddFileWidgetState();
}

class _AddFileWidgetState extends State<AddFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.file.existsSync() == true
          ? SizedBox(
              height: 6.h,
              width: 6.w,
              child: PostPickedImage(
                postImage: widget.file,
                setState: setState,
              ),
            )
          : InkWell(
              onTap: pickImageFromGallery,
              child: Image.asset(
                "assets/icons/plus.png",
                height: 6.h,
                width: 6.w,
                color: const Color.fromARGB(255, 192, 250, 223),
              ),
            ),
    );
  }

  void pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      widget.file = File(pickedImage.path);
    });

    widget.callback(widget.file);

    print(pickedImage);
  }
}
