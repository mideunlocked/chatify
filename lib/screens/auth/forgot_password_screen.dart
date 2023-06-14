import 'package:chatify/providers/auth.dart';
import 'package:chatify/widgets/auth_widget/auth_app_bar.dart';
import 'package:chatify/widgets/auth_widget/auth_button.dart';
import 'package:chatify/widgets/auth_widget/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;

  final controller = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const AuthAppBar(
                title: "Forgot password",
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot your password? Enter your registered email address and we'll send you a password reset link.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AuthTextField(
                      controller: controller,
                      node: FocusNode(),
                      hint: "Enter email address",
                      label: "Email address",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AuthButton(
                      text: "Send reset email",
                      fucntion: () => sendResetLink(),
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendResetLink() async {
    setState(() {
      isLoading = true;
    });
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    var result = await authProvider.resetPassword(
      controller.text.trim(),
    );

    if (result = true) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content:
              Text("Password reset link sent to ${controller.text.trim()}"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print(result);
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(result.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
