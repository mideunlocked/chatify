import 'package:chatify/providers/auth.dart';
import 'package:chatify/screens/auth/login_screen.dart';
import 'package:chatify/widgets/auth_widget/auth_animation_widget.dart';
import 'package:chatify/widgets/auth_widget/auth_app_bar.dart';
import 'package:chatify/widgets/auth_widget/auth_button.dart';
import 'package:chatify/widgets/auth_widget/auth_textfield.dart';
import 'package:chatify/widgets/auth_widget/have_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final ageController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ageNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final nameNode = FocusNode();
  final usernameNode = FocusNode();
  final confirmNode = FocusNode();
  final phoneNumberNode = FocusNode();

  bool isAgree = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();

    ageController.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    ageNode.dispose();
    nameNode.dispose();
    usernameNode.dispose();
    confirmNode.dispose();
    phoneNumberNode.dispose();
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
                  padding: EdgeInsets.only(top: 3.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // animation widget
                          const AuthAnimationWidget(
                            url:
                                "https://assets3.lottiefiles.com/packages/lf20_eYXADRNJPy.json",
                          ),
                          SizedBox(
                            height: 3.h,
                          ),

                          AuthTextField(
                            controller: nameController,
                            node: nameNode,
                            inputType: TextInputType.name,
                            hint: "Enter your full name",
                            label: "Full name",
                          ),

                          AuthTextField(
                            controller: usernameController,
                            node: usernameNode,
                            inputType: TextInputType.name,
                            hint: "Enter your username",
                            label: "Username",
                          ),

                          AuthTextField(
                            controller: phoneNumberController,
                            node: phoneNumberNode,
                            inputType: TextInputType.number,
                            hint: "Enter your phone number",
                            label: "Phone number",
                          ),

                          // age textfield
                          AuthTextField(
                            controller: ageController,
                            node: ageNode,
                            inputType: TextInputType.number,
                            hint: "Enter your age",
                            label: "Age",
                          ),

                          // email textfield
                          AuthTextField(
                            controller: emailController,
                            node: emailNode,
                            inputType: TextInputType.emailAddress,
                            hint: "Enter your email address",
                            label: "Email address",
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

                          // confirm password
                          AuthTextField(
                            controller: confirmPasswordController,
                            node: confirmNode,
                            password: passwordController.text.trim(),
                            inputType: TextInputType.emailAddress,
                            hint: "Confirm password",
                            label: "Confirm password",
                            isObscure: true,
                            isPassword: true,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: isAgree,
                                onChanged: (value) {
                                  setState(() {
                                    isAgree = !isAgree;
                                  });
                                },
                              ),
                              const Text("I agree with the "),
                              const Text(
                                "terms and conditions",
                                style: TextStyle(
                                  color: color2,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5.h,
                          ),

                          // Login button
                          Center(
                            child: AuthButton(
                              text: "Sign up",
                              isLoading: isLoading,
                              fucntion: () => createUser(),
                            ),
                          ),

                          // Have account check
                          const HaveAccountWidget(
                            checkText: "Already have an account",
                            actionText: "Login",
                            widget: LoginScreen(),
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

  void createUser() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid == false && isAgree == false) {
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      final response = await Provider.of<AuthProvider>(context, listen: false)
          .createUserEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        phoneNumberController.text.trim(),
        usernameController.text.trim(),
        ageController.text.trim(),
        isAgree,
      );

      if (response != true) {
        setState(() {
          isLoading = false;
        });
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
              (route) => false);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
