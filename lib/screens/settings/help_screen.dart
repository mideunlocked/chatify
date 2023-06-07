import 'package:chatify/screens/settings/dev_cont_screen.dart';
import 'package:chatify/widgets/settings_widget/setting_child_app_bar.dart';
import 'package:chatify/widgets/settings_widget/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              subtitle: "Take a look at our terms and privacy policy",
              icon: Icons.book_outlined,
              title: "Terms and Privacy Policy",
              screenWidget: Container(),
              function: () async {
                final url = Uri.parse(
                    "https://docs.google.com/document/d/1mvKBsKh-TahJ1xOwIC5g7DrMltS7y_kGvANyAn6Brck/edit");
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
