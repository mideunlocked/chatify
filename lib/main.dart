import 'package:chatify/providers/chatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Chatting(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            indicatorColor: const Color.fromARGB(255, 192, 250, 223),
            scaffoldBackgroundColor: const Color.fromARGB(255, 0, 19, 29),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              bodyMedium: TextStyle(
                fontFamily: "Poppins",
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                color: Colors.white30,
                fontSize: 11.sp,
                fontFamily: "Poppins",
              ),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

// import 'package:chatify/screens/messages_list_screen.dart';
// import 'package:flutter/material.dart';

// import '../widgets/home_screen_widget/custom_nav.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final pageController = PageController();

//   @override
//   void dispose() {
//     super.dispose();

//     pageController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           // home screen pages with page view
//           PageView(
//             controller: pageController,
//             physics: const NeverScrollableScrollPhysics(),
//             children: pages,
//           ),

//           // custom bottom nav
//           CustomBottomNav(
//             pageController: pageController,
//           ),
//         ],
//       ),
//     );
//   }
// }

// List<Widget> pages = [
//   const MessagesScreen(),
//   const Center(
//     child: Text("Groups"),
//   ),
//   const Center(
//     child: Text("Communities"),
//   ),
//   const Center(
//     child: Text("search"),
//   ),
//   const Center(
//     child: Text("Settings"),
//   ),
// ];
