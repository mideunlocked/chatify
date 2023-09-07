import 'package:chatify/helpers/tc_pp.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/settings_widget/setting_child_app_bar.dart';
import '../../widgets/settings_widget/settings_list_tile.dart';
import 'dev_cont_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SettingChildAppBar(title: "Help"),
            // SettingListTile(
            //   subtitle: "Questions? Need help?",
            //   icon: Icons.people_rounded,
            //   title: "Contact us",
            //   screenWidget: Container(),
            // ),
            SettingListTile(
              subtitle: "Take a look at our terms and condition",
              icon: Icons.book_outlined,
              title: "Terms and Condition",
              screenWidget: Container(),
              isHelp: true,
              function: () async {
                final url = Uri.parse(terms_and_condition);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw "Could not launch $url";
                }
              },
            ),
            SettingListTile(
              subtitle: "Take a look at our privacy policy",
              icon: Icons.book_outlined,
              title: "Privacy Policy",
              screenWidget: Container(),
              isHelp: true,
              function: () async {
                final url = Uri.parse(privacy_policy);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw "Could not launch $url";
                }
              },
            ),
            SettingListTile(
              subtitle: "Contact the developer",
              icon: Icons.perm_contact_cal_rounded,
              title: "Developer contact",
              screenWidget: const DevContScreen(),
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
