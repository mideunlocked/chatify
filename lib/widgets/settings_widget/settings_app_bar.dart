import 'package:chatify/screens/auth/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    const radius = Radius.circular(35);

    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 7, 49, 73).withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Settings",
            style: textTheme.bodyLarge,
          ),
          const SettingsMoreButton(),
        ],
      ),
    );
  }
}

class SettingsMoreButton extends StatefulWidget {
  const SettingsMoreButton({
    super.key,
  });

  @override
  State<SettingsMoreButton> createState() => _SettingsMoreButtonState();
}

class _SettingsMoreButtonState extends State<SettingsMoreButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Logout"),
              SizedBox(
                width: 3.w,
              ),
              Image.asset(
                "assets/icons/exit.png",
                height: 5.h,
                width: 5.w,
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        if (value == 1) {
          await FirebaseAuth.instance.signOut();
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const WelcomeScreen(),
              ),
            );
          }
        }
      },
      child: Image.asset(
        "assets/icons/more.png",
        color: Colors.white,
        height: 8.h,
        width: 8.w,
      ),
    );
  }
}
