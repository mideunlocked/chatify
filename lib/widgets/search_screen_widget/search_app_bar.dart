import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../home_screen_widget/app_bar_images.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.controller,
    required this.function,
  });

  final TextEditingController controller;
  final Function function;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(35);

    return Container(
      height: 8.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 8.w,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: TextField(
              controller: controller,
              cursorColor: const Color.fromARGB(255, 192, 250, 223),
              textInputAction: TextInputAction.search,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onSubmitted: (value) {
                function();
              },
            ),
          ),
          Visibility(
            visible: false,
            child: AppBarIcon(
              url: "assets/icons/search.png",
              function: () {},
            ),
          ),
        ],
      ),
    );
  }
}
