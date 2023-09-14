import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/full_image_screen.dart';
import '../general_widget/custom_progress_indicator.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 2.h,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FullImageScreen(
                imageUrl: imageUrl,
              ),
            ),
          ),
          child: Image.network(
            imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const CustomProgressIndicator();
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Center(
                child: Image.asset(
                  "assets/icons/picture.png",
                  height: 5.h,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
