import 'package:flutter/material.dart';

import '../widgets/home_screen_widget/custom_nav.dart';
import 'chat-screens/group_messaging_screen.dart';
import 'chat-screens/messages_list_screen.dart';
import 'search_screen.dart';
import 'settings/settings_screen.dart';
import 'spaces/spaces_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;

  final pageController = PageController(
    initialPage: 2,
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
  const GroupMessagesScreen(),
  const SpacesScreen(),
  const SearchScreen(),
  const SettingScreen(),
];
