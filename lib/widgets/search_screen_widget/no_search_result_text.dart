import 'package:flutter/material.dart';

class NoSearchResultText extends StatelessWidget {
  const NoSearchResultText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
