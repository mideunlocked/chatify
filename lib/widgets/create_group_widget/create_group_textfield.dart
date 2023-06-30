import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CreateGroupTextFeild extends StatefulWidget {
  CreateGroupTextFeild({
    super.key,
    required this.controller,
    required this.node,
    this.inputType = TextInputType.name,
    required this.inputAction,
    this.isObscure = false,
    this.password = "",
    this.isPassword = false,
    this.maxLines = 1,
    required this.hint,
    required this.label,
    required this.maxText,
    required this.newNode,
  });

  final TextEditingController controller;
  final FocusNode node;
  final FocusNode newNode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  bool isObscure;
  bool isPassword;
  final String hint;
  final String label;
  final String password;
  final int maxText;
  final int maxLines;

  @override
  State<CreateGroupTextFeild> createState() => _CreateGroupTextFeildState();
}

class _CreateGroupTextFeildState extends State<CreateGroupTextFeild> {
  int textLength = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.node,
        maxLength: widget.maxText,
        maxLines: widget.maxLines,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        cursorColor: const Color.fromARGB(255, 192, 250, 223),
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: widget.hint,
          labelText: widget.label,
          // suffix: Text(),
          suffixText: "$textLength/${widget.maxText}",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "${widget.label} is required";
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            textLength = value.length;
          });
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.newNode);
        },
      ),
    );
  }
}
