import 'package:chatify/widgets/spaces/spaces_app_bar.dart';
import 'package:flutter/material.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SpacesAppBar(),
        ],
      ),
    );
  }
}
