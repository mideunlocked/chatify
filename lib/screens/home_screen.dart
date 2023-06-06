import 'package:chatify/screens/messages_list_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen_widget/custom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();

  var currentIndex = 0;

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  const Center(
    child: Text("Groups"),
  ),
  const Center(
    child: Text("Communities"),
  ),
  const Center(
    child: Text("search"),
  ),
  const Center(
    child: Text("Settings"),
  ),
];
