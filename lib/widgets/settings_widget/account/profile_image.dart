import 'dart:io';

import 'package:chatify/providers/image_handling_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../general_widget/custom_progress_indicator.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  bool isUploading = false;
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70.sp,
              backgroundColor: Colors.grey,
              foregroundImage: widget.imageUrl.isEmpty == false
                  ? NetworkImage(widget.imageUrl)
                  : null,
            ),
          ],
        ),
        Positioned(
          left: 60.w,
          child: InkWell(
            onTap: () => pickImageFromGallery(),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 4, 255, 138),
              radius: 18.sp,
              child: isUploading == true
                  ? const CustomProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0,
                    )
                  : Image.asset(
                      "assets/icons/camera.png",
                      color: const Color.fromARGB(255, 0, 34, 53),
                      height: 7.h,
                      width: 7.w,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void pickImageFromGallery() async {
    final imageHandlingProvider = Provider.of<ImageHandlingProvider>(
      context,
      listen: false,
    );

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedImage == null) {
      return;
    }

    File imageFile = File(pickedImage.path);

    setState(() {
      isUploading = true;
    });
    await imageHandlingProvider.uploadProfileImage(imageFile);
    setState(() {
      isUploading = false;
    });
  }
}
