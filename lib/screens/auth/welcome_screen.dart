import 'package:chatify/screens/auth/login_screen.dart';
import 'package:chatify/screens/auth/sign_up_screen.dart';
import 'package:chatify/widgets/auth_widget/auth_button.dart';
import 'package:chatify/widgets/auth_widget/chatify_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 2.h,
    );
    var sizedBox2 = SizedBox(
      height: 5.h,
    );
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
            horizontal: 2.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ChatifyText(),
                Lottie.network(
                  "https://assets8.lottiefiles.com/packages/lf20_fjv8qxqn.json",
                  height: 50.h,
                  width: 80.w,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      "assets/images/logo-1.png",
                      height: 50.h,
                      width: 80.w,
                      fit: BoxFit.contain,
                    );
                  },
                ),
                Text(
                  "Welcome to Chatify, where meaningful conversations happen!",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                sizedBox,
                Text(
                  "Let's get you started on a seamless messaging experience with Chatify!",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 8.sp,
                  ),
                ),
                sizedBox2,
                AuthButton(
                  text: "Login",
                  isLoading: false,
                  fucntion: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const LoginScreen(),
                    ),
                  ),
                ),
                sizedBox,
                AuthButton(
                  text: "Sign up",
                  isLoading: false,
                  fucntion: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const SignupScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
