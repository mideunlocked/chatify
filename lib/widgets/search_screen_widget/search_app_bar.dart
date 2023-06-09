import 'package:chatify/screens/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../home_screen_widget/app_bar_images.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SearchResultScreen(
                      searchText: value,
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: false,
            child: GestureDetector(
              onTap: () {},
              child: AppBarIcon(
                url: "assets/icons/search.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//               future: postProvider.searchPost(),
//               builder: (context, snapshot) {
//                 return Expanded(
//                   child: ListView(
//                     children: snapshot.data!.docs
//                         .where(
//                           (element) => element["text"].toString().contains(
//                                 controller.text.trim(),
//                               ),
//                         )
//                         .map(
//                           (result) => Text(
//                             result["text"] ?? "",
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 );
//               }),