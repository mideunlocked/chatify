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
            primaryColor: const Color.fromARGB(255, 0, 34, 53),
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
                fontSize: 10.sp,
                fontFamily: "Poppins",
              ),
            ),
            textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                    fontFamily: "Poppins",
                    color: Color.fromARGB(255, 192, 250, 223),
                  ),
                ),
              ),
            ),
            listTileTheme: ListTileThemeData(
              titleTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              subtitleTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 9.sp,
                color: Colors.white60,
              ),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
