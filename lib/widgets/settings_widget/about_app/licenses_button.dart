import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LicensesButton extends StatelessWidget {
  const LicensesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAboutDialog(
        context: context,
        applicationName: "Chatify",
        applicationIcon: Image.asset(
          "assets/images/logo-1.png",
          width: 40,
          height: 40,
        ),
        applicationVersion: "1.2.1",
        applicationLegalese:
            "Before diving into the licenses for the resources used in the app, it's important to emphasize the significance of respecting intellectual property rights and adhering to licensing requirements. The app serves as a functional software application, providing users with a seamless and engaging experience. Throughout the development process, careful consideration has been given to ensure compliance with relevant licenses and permissions. This includes using open-source frameworks like Flutter itself, along with legally obtained images, graphics, icons, fonts, and third-party libraries. By upholding licensing obligations, we demonstrate our commitment to ethical practices and acknowledge the value of the creative works that contribute to the app's functionality and visual appeal.",
      ),
      child: Container(
        height: 6.h,
        width: 40.w,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 192, 250, 223),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Text(
          "Licenses",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 34, 53),
          ),
        ),
      ),
    );
  }
}
