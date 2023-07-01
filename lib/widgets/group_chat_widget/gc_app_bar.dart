import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widget/custom_back_button.dart';
import 'gc_detail_dialog.dart';

class GCChatScreenAppBar extends StatelessWidget {
  const GCChatScreenAppBar({
    super.key,
    required this.about,
    required this.participants,
    required this.admins,
    required this.requests,
    required this.groupId,
  });

  final Map<String, dynamic> about;
  final List<dynamic> requests;
  final List<dynamic> admins;
  final List<dynamic> participants;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          const CustomBackButton(),

          // title (Name, and isOnline)
          Column(
            children: [
              // name
              Text(
                about["name"] ?? "",
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),

          // profile picture
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => showDetails(context),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 17.sp,
              backgroundImage: const AssetImage("assets/images/logo-2.png"),
            ),
          ),
        ],
      ),
    );
  }

  void showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => GCDetailsDialog(
        about: about,
        participants: participants,
        admins: admins,
        reuqests: requests,
        groupId: groupId,
      ),
    );
  }
}
