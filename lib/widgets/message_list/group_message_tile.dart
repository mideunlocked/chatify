import 'package:chatify/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GroupMessageTile extends StatelessWidget {
  const GroupMessageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    // var openImage = Image.asset(
    //                 "assets/icons/global-network.png",
    //                 color: Colors.blue,
    //                 height: 10.sp,
    //                 width: 10.sp,
    //               );
    var lockedImage = Image.asset(
      "assets/icons/lock.png",
      color: Colors.red,
      height: 10.sp,
      width: 10.sp,
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.w,
          ),
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 17.sp,
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Row(
                children: [
                  Text(
                    "Fpl Heroes",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  lockedImage,
                ],
              ),
            ),
            subtitle: Text(
              "Man utd vs gunners who is winning?",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color.fromARGB(255, 192, 250, 223),
                fontSize: 10.sp,
              ),
            ),
            trailing: Stack(
              alignment: Alignment.topRight,
              children: [
                // time widget
                Text(
                  "02:30 pm",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 9.sp,
                  ),
                ),

                // space
                SizedBox(
                  height: 5.sp,
                ),

                // unread message indicator
                Container(
                  height: 5.h,
                  width: 5.w,
                  margin: EdgeInsets.only(top: 10.sp),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 192, 250, 223),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 34, 53),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // divider for seperation
        const Divider(
          color: Colors.white12,
          thickness: 0.5,
        ),
      ],
    );
  }
}
