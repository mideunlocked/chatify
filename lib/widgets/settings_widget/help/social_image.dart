import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialImage extends StatelessWidget {
  const SocialImage({
    super.key,
    required this.imageUrl,
    required this.link,
  });

  final String imageUrl;
  final String link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw "Could not launch $url";
        }
      },
      child: Image.asset(
        imageUrl,
        height: 7.h,
        width: 7.w,
      ),
    );
  }
}
