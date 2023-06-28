import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../helpers/gc_status.dart';
import 'future_username_text.dart';

class GCDetailsDialog extends StatelessWidget {
  const GCDetailsDialog({
    super.key,
    required this.about,
    required this.admins,
    required this.participants,
  });

  final Map<String, dynamic> about;
  final List<dynamic> admins;
  final int participants;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    var textStyle = const TextStyle(
      color: Colors.white60,
    );
    var dateTime = DateTimeFormatting().formatTimeDate(
      about["createdOn"] ?? Timestamp.now(),
    );
    var sizedBox = SizedBox(
      height: 1.h,
    );

    return Dialog(
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 40.h,
        width: 80.w,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.h,
            horizontal: 3.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/logo-2.png",
                  height: 10.h,
                  width: 22.w,
                  fit: BoxFit.cover,
                ),
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    about["name"] ?? "",
                    style: textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  about["isPublic"] == true ? openImage : lockedImage,
                ],
              ),
              sizedBox,
              Text(
                about["description"] ?? "",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "$participants participants",
                style: textStyle,
              ),
              FutureUsernameText(
                uid: admins.first ?? "",
                textStyle: textStyle,
                keyString: "Admin",
              ),
              FutureUsernameText(
                uid: about["createdBy"] ?? "",
                textStyle: textStyle,
                keyString: "Created by",
              ),
              Text(
                "Created on: ${dateTime[1]}",
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
