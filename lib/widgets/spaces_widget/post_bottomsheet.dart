import 'dart:io';

import 'package:chatify/providers/post_provider.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'post_picked_image.dart';

class PostBottomsheet extends StatefulWidget {
  const PostBottomsheet({
    super.key,
  });

  @override
  State<PostBottomsheet> createState() => _PostBottomsheetState();
}

class _PostBottomsheetState extends State<PostBottomsheet> {
  final controller = TextEditingController();
  File postImage = File("");

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 30.h,
        width: 100.w,
        color: const Color.fromARGB(255, 0, 34, 53),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
          child: isLoading == true
              ? const CustomProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Post space conversation",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        cursorColor: const Color.fromARGB(255, 192, 250, 223),
                        maxLines: 5,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                        decoration: const InputDecoration(
                          hintText: "What's on your mind",
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        onSubmitted: (_) => addPost(context),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        postImage.existsSync() == false
                            ? IconButton(
                                onPressed: () => pickImageFromGallery(),
                                icon: Image.asset("assets/icons/picture.png"),
                              )
                            : PostPickedImage(
                                postImage: postImage,
                                setState: setState,
                              ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            controller.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () => addPost(context),
                          child: const Text(
                            "Post",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      postImage = File(pickedImage.path);
    });

    print(postImage);
  }

  void addPost(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var postProvider = Provider.of<PostProvider>(context, listen: false);

    await postProvider.addPost(
      controller.text.trim(),
      postImage,
    );
    if (mounted) {
      Navigator.pop(context);
    }

    setState(() {
      isLoading = false;
    });
  }
}
