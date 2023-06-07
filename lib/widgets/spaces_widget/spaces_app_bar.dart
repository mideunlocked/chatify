import 'dart:ui';

import 'package:chatify/widgets/home_screen_widget/app_bar_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpacesAppBar extends StatelessWidget {
  const SpacesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    const radius = Radius.circular(35);

    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Spaces",
            style: textTheme.bodyLarge,
          ),
          GestureDetector(
            onTap: () => postSpaceConversation(context),
            child: AppBarIcon(
              url: "assets/icons/plus.png",
            ),
          ),
        ],
      ),
    );
  }

  void postSpaceConversation(BuildContext context) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: const PostBottomsheet());
      },
    );
  }
}

class PostBottomsheet extends StatefulWidget {
  const PostBottomsheet({
    super.key,
  });

  @override
  State<PostBottomsheet> createState() => _PostBottomsheetState();
}

class _PostBottomsheetState extends State<PostBottomsheet> {
  final controller = TextEditingController();

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
          child: Column(
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
              TextField(
                controller: controller,
                cursorColor: const Color.fromARGB(255, 192, 250, 223),
                maxLines: 5,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "What's on your mind",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(182, 226, 252, 1),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(182, 226, 252, 1),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(182, 226, 252, 1),
                      width: 1.5,
                    ),
                  ),
                ),
                onSubmitted: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    onPressed: () {},
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
}
