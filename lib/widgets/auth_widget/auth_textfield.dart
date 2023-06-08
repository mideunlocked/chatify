import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AuthTextField extends StatefulWidget {
  AuthTextField({
    super.key,
    required this.controller,
    required this.node,
    this.inputType = TextInputType.name,
    this.inputAction = TextInputAction.next,
    this.isObscure = false,
    this.password = "",
    this.isPassword = false,
    required this.hint,
    required this.label,
  });

  final TextEditingController controller;
  final FocusNode node;
  final TextInputType inputType;
  final TextInputAction inputAction;
  bool isObscure;
  bool isPassword;
  final String hint;
  final String label;
  final String password;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.node,
        obscureText: widget.isObscure,
        cursorColor: const Color.fromARGB(255, 192, 250, 223),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.isPassword == false
              ? const Text("")
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure;
                    });
                  },
                  icon: Icon(
                    widget.isObscure == true
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.white30,
                  ),
                ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "${widget.label} is required";
          }
          if (widget.label == "Username" && value.length < 3) {
            return 'Username must be at least 3 characters long.';
          }
          if (widget.label == "Username" &&
              !RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
            return 'Username must contain only letters, numbers, and underscores.';
          }
          if (widget.label == "Phone number" &&
              !RegExp(r'^[+]?[0-9]{10,13}$').hasMatch(value)) {
            return 'Please enter a valid mobile number.';
          }
          if (widget.label == "Email address" &&
              value.contains(".com") == false) {
            return "Invalid email address";
          }
          if (widget.label == "Age" && value.length > 3) {
            return "Enter a valid age";
          }
          if (widget.label == "Confirm password" &&
              widget.controller.text.trim() != widget.password) {
            return "Confrim password doesn't match";
          }
          return null;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
