import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.subtitle,
    required this.icon,
    required this.title,
    this.isHelp = false,
    required this.function,
    required this.screenWidget,
  });

  final VoidCallback function;
  final Widget screenWidget;
  final String subtitle;
  final IconData icon;
  final String title;
  final bool isHelp;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var listTileTheme = of.listTileTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: ListTile(
        onTap: () {
          if (isHelp == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return screenWidget;
                },
              ),
            );
          } else {
            fucntion;
          }
        },
        leading: Icon(
          icon,
          color: Colors.white60,
        ),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: listTileTheme.subtitleTextStyle,
        ),
      ),
    );
  }
}
