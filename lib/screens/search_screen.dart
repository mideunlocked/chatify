import 'package:chatify/widgets/search_screen_widget/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'search/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchAppBar(
            controller: controller,
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => SearchResultScreen(
                    searchText: controller.text.trim(),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: const Text(
              "Try searching for username or conversations",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
