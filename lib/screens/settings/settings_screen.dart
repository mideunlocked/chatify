import 'package:chatify/screens/settings/about_app.dart';
import 'package:chatify/screens/settings/account_screen.dart';
import 'package:chatify/screens/settings/help_screen.dart';
import 'package:chatify/widgets/settings_widget/settings_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings_widget/settings_list_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SettingsAppBar(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SettingListTile(
                    icon: Icons.key_rounded,
                    title: "Account",
                    subtitle: "Change your username, full name, email, number",
                    screenWidget: AccountScreen(),
                    function: () {},
                  ),
                  SettingListTile(
                    icon: Icons.info_outline_rounded,
                    title: "About app",
                    subtitle: "About app, licenses",
                    screenWidget: AboutAppScreen(),
                    function: () {},
                  ),
                  SettingListTile(
                    icon: Icons.help_outline_rounded,
                    title: "Help",
                    subtitle: "Help center, contact us, privacy policy",
                    screenWidget: HelpScreen(),
                    function: () {},
                  ),
                ],
              ),
            ),
            const Text(
              "From",
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
            Text(
              "© 2023 Stact Platforms Inc.",
              style: TextStyle(
                color: Colors.amber[900],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
