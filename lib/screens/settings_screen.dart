import 'package:chatify/widgets/settings/settings_app_bar.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(),
          ],
        ),
      ),
    );
  }
}
