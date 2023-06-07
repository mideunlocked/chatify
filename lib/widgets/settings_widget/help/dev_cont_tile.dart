import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DevContTile extends StatelessWidget {
  const DevContTile({
    super.key,
    required this.iconUrl,
    required this.title,
    this.link = "",
  });

  final String iconUrl;
  final String link;
  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var listTileTheme = of.listTileTheme;

    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw "Could not launch $url";
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.5.h,
          horizontal: 2.w,
        ),
        child: ListTile(
          leading: iconImage(
            iconUrl,
          ),
          title: Text(
            title,
            style: listTileTheme.titleTextStyle,
          ),
        ),
      ),
    );
  }

  Image iconImage(String url, {Color color = Colors.white60}) {
    return Image.asset(
      url,
      color: color,
      height: 5.h,
      width: 5.w,
    );
  }
}
