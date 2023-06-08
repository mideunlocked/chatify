import 'package:chatify/providers/auth.dart';
import 'package:chatify/providers/chatting.dart';
import 'package:chatify/providers/comment_provider.dart';
import 'package:chatify/providers/post_provider.dart';
import 'package:chatify/screens/auth/welcome_screen.dart';
import 'package:chatify/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          ChangeNotifierProvider(
            create: (context) => PostProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CommentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            indicatorColor: const Color.fromARGB(255, 192, 250, 223),
            scaffoldBackgroundColor: const Color.fromARGB(255, 0, 19, 29),
            primaryColor: const Color.fromARGB(255, 0, 34, 53),
            checkboxTheme: const CheckboxThemeData(
              checkColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 0, 34, 53)),
              fillColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 192, 250, 223),
              ),
            ),
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
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 192, 250, 223),
              ),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 192, 250, 223),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 192, 250, 223),
                  width: 1,
                ),
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
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const WelcomeScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
