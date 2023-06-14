import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/auth/forgot_password_screen.dart';

class ForgotPasswordTile extends StatelessWidget {
  const ForgotPasswordTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var listTileTheme = of.listTileTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0.5.h,
        horizontal: 2.w,
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const ForgotPasswordScreen(),
            ),
          );
        },
        leading: Icon(
          Icons.password_rounded,
          color: Colors.white60,
          size: 3.h,
        ),
        title: Text(
          "Password",
          style: listTileTheme.subtitleTextStyle,
        ),
        subtitle: Text(
          "Reset your password",
          style: listTileTheme.titleTextStyle
              ?.copyWith(fontWeight: FontWeight.w300),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color.fromARGB(255, 4, 255, 138),
        ),
      ),
    );
  }
}
