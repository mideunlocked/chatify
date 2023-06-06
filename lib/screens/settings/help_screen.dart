import 'package:chatify/widgets/general_widget/custom_back_button.dart';
import 'package:chatify/widgets/settings_widget/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Row(
                    children: [
                      CustomBackButton(),
                    ],
                  ),
                  Text(
                    "Help",
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            // SettingListTile(
            //   subtitle: "Questions? Need help?",
            //   icon: Icons.people_rounded,
            //   title: "Contact us",
            //   screenWidget: Container(),
            // ),
            SettingListTile(
              subtitle: "Take a look at our terms and privacy policy",
              icon: Icons.book_outlined,
              title: "Terms and Privacy Policy",
              screenWidget: Container(),
              function: () {},
            ),
            SettingListTile(
              subtitle: "Contact the developer",
              icon: Icons.perm_contact_cal_rounded,
              title: "Developer contact",
              screenWidget: Container(),
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
