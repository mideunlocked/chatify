import 'package:flutter/material.dart';

import 'package:chatify/widgets/settings_widget/setting_child_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings_widget/account/account_list_tile.dart';
import '../../widgets/settings_widget/account/profile_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            const SettingChildAppBar(),

            // list of items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                children: [
                  // profile image
                  const ProfileImage(),

                  // space
                  SizedBox(
                    height: 2.h,
                  ),

                  // full name
                  const AccountListTile(
                    title: "Full name",
                    subtitle: "John Doe",
                    iconUrl: "assets/icons/user.png",
                  ),

                  // username
                  const AccountListTile(
                    title: "username",
                    subtitle: "@johndoe",
                    iconUrl: "assets/icons/arroba.png",
                  ),

                  // email address
                  const AccountListTile(
                    title: "Email address",
                    subtitle: "johndoe@gmail.com",
                    iconUrl: "assets/icons/postbox.png",
                  ),

                  // phone number
                  const AccountListTile(
                    title: "Phone number",
                    subtitle: "09012345678",
                    iconUrl: "assets/icons/telephone.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
