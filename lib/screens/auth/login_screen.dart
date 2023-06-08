import 'package:chatify/providers/auth.dart';
import 'package:chatify/screens/auth/welcome_screen.dart';
import 'package:chatify/widgets/auth_widget/auth_animation_widget.dart';
import 'package:chatify/widgets/auth_widget/auth_app_bar.dart';
import 'package:chatify/widgets/auth_widget/have_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widget/auth_textfield.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginDetailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    loginDetailController.dispose();
    passwordController.dispose();

    emailNode.dispose();
    passwordNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    const color2 = Color.fromARGB(255, 192, 250, 223);

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Custom app bar
              const AuthAppBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // animation widget
                          const AuthAnimationWidget(
                            url:
                                "https://assets3.lottiefiles.com/packages/lf20_ussodo4a.json",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),

                          // email textfield
                          AuthTextField(
                            controller: loginDetailController,
                            node: emailNode,
                            inputType: TextInputType.emailAddress,
                            hint: "Enter your username or email address",
                            label: "Username/Email address",
                          ),

                          // password textfield
                          AuthTextField(
                            controller: passwordController,
                            node: passwordNode,
                            inputType: TextInputType.emailAddress,
                            hint: "Enter your password",
                            label: "Password",
                            isObscure: true,
                            isPassword: true,
                          ),

                          // forgot password
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: color2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),

                          // Login button
                          Center(
                            child: AuthButton(
                              text: "Login",
                              fucntion: () => signIn(),
                            ),
                          ),

                          // Have account check
                          const HaveAccountWidget(
                            checkText: "Don't have an account",
                            actionText: "Sign up now",
                            widget: SignupScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid == false) {
      return;
    } else {
      final response =
          await Provider.of<AuthProvider>(context, listen: false).signInUSer(
        loginDetailController.text.trim(),
        passwordController.text.trim(),
      );
      if (response != true) {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
