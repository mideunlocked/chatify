import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings_widget/help/dev_cont_tile.dart';
import '../../widgets/settings_widget/help/social_image.dart';
import '../../widgets/settings_widget/setting_child_app_bar.dart';

class DevContScreen extends StatelessWidget {
  const DevContScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            const SettingChildAppBar(title: "Developer Contact"),

            // list of items
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Column(
                  children: [
                    // profile image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/iamlamide.jpg",
                        fit: BoxFit.fill,
                        height: 25.h,
                        width: 50.w,
                      ),
                    ),

                    // space
                    SizedBox(
                      height: 2.h,
                    ),

                    // Dev contact infos
                    const DevContTile(
                      iconUrl: "assets/icons/user.png",
                      title: "Osuolale Ariyo",
                    ),
                    const DevContTile(
                      iconUrl: "assets/icons/postbox.png",
                      title: "osuolaleariyo@gmail.com",
                      link:
                          'mailto:osuolaleariyo@gmail.com?subject=Contact Ariyo?body=email',
                    ),
                    const DevContTile(
                      iconUrl: "assets/icons/telephone.png",
                      title: "+2347040225758",
                      link: 'tel:+2347040225758',
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialImage(
                          imageUrl: "assets/icons/instagram.png",
                          link: "https://www.instagram.com/_iamlamide/",
                        ),
                        SocialImage(
                          imageUrl: "assets/icons/twitter.png",
                          link: "https://twitter.com/_iamlamide",
                        ),
                        SocialImage(
                          imageUrl: "assets/icons/linkedin.png",
                          link: "https://www.linkedin.com/in/ariyo-osuolale",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
