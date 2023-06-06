import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'account_list_tile.dart';

// ignore: must_be_immutable
class EditDialog extends StatefulWidget {
  EditDialog({
    super.key,
    required this.widget,
    required this.controller,
  });

  final AccountListTile widget;
  TextEditingController controller;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var color = const Color.fromARGB(255, 192, 250, 223);
    var underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
    );

    return SizedBox(
      height: 22.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter you ${widget.widget.title.toLowerCase()}",
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            TextField(
              controller: widget.controller,
              focusNode: focusNode,
              maxLength: 25,
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      maxLength}) =>
                  Text(
                "$currentLength/$maxLength",
                style: TextStyle(
                  color: color,
                  fontSize: 8.sp,
                ),
              ),
              style: textTheme.bodyMedium,
              cursorColor: color,
              decoration: InputDecoration(
                focusedBorder: underlineInputBorder,
                enabledBorder: underlineInputBorder,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
