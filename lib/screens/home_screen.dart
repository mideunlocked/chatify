// import 'package:chatify/screens/group_messaging_screen.dart';
import 'package:chatify/screens/messages_list_screen.dart';
import 'package:chatify/screens/search_screen.dart';
import 'package:chatify/screens/settings/settings_screen.dart';
import 'package:chatify/screens/spaces/spaces_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen_widget/custom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  final pageController = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // home screen pages with page view
          PageView(
            controller: pageController,
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
          ),

          // custom bottom nav
          CustomBottomNav(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}

List<Widget> pages = [
  const MessagesScreen(),
  // const GroupMessagesScreen(),
  const SpacesScreen(),
  const SearchScreen(),
  const SettingScreen(),
];
