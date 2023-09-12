import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

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

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bottom navigation pages
    List<Widget> pages = [
      MessagesScreen(
        scrollController: scrollController,
      ),
      GroupMessagesScreen(
        scrollController: scrollController,
      ),
      SpacesScreen(
        scrollController: scrollController,
      ),
      const SearchScreen(),
      SettingScreen(
        scrollController: scrollController,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // home screen pages with page view
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
            children: pages,
          ),

          // custom bottom nav
          AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: scrollController.hasClients &&
                        scrollController.position.userScrollDirection ==
                            ScrollDirection.reverse
                    ? 0
                    : 10.h,
                child: child,
              );
            },
            child: CustomBottomNav(
              pageController: pageController,
              currentIndex: currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}
