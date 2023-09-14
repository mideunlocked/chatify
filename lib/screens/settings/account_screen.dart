import 'package:chatify/providers/user_provider.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chatify/widgets/settings_widget/setting_child_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings_widget/account/account_list_tile.dart';
import '../../widgets/settings_widget/account/forgot_password_tile.dart';
// import '../../widgets/settings_widget/account/profile_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            const SettingChildAppBar(title: "Account"),

            // list of items
            Expanded(
              child: StreamBuilder(
                  stream: userProvider.getUser(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CustomProgressIndicator();
                    } else if (snapshot.hasData == false) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nothing to show here",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white60),
                        ),
                      );
                    }
                    return ListView(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot data) {
                        Map<String, dynamic> user =
                            data.data()! as Map<String, dynamic>;

                        return Column(
                          children: [
                            // // profile image
                            // const ProfileImage(),

                            // SizedBox(
                            //   height: 2.h,
                            // ),

                            // full name
                            AccountListTile(
                              dataKey: "fullName",
                              title: "Full name",
                              subtitle: user["fullName"] ?? "",
                              iconUrl: "assets/icons/user.png",
                            ),

                            // username
                            AccountListTile(
                              dataKey: "username",
                              title: "username",
                              subtitle: "@${user["username"]}",
                              iconUrl: "assets/icons/arroba.png",
                            ),

                            // email address
                            AccountListTile(
                              dataKey: "email",
                              title: "Email address",
                              subtitle: user["email"] ?? "",
                              iconUrl: "assets/icons/postbox.png",
                            ),

                            // phone number
                            AccountListTile(
                              dataKey: "phoneNumber",
                              title: "Phone number",
                              subtitle: user["phoneNumber"] ?? "",
                              iconUrl: "assets/icons/telephone.png",
                            ),

                            // reset password
                            const ForgotPasswordTile(),
                          ],
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
