import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'edit_dialog.dart';

class AccountListTile extends StatefulWidget {
  const AccountListTile({
    super.key,
    required this.subtitle,
    this.iconUrl = "",
    required this.title,
  });

  final String subtitle;
  final String iconUrl;
  final String title;

  @override
  State<AccountListTile> createState() => _AccountListTileState();
}

class _AccountListTileState extends State<AccountListTile> {
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.subtitle,
    );
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

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
        leading: iconImage(
          widget.iconUrl,
        ),
        title: Text(
          widget.title,
          style: listTileTheme.subtitleTextStyle,
        ),
        subtitle: Text(
          widget.subtitle,
          style: listTileTheme.titleTextStyle
              ?.copyWith(fontWeight: FontWeight.w300),
        ),
        trailing: GestureDetector(
          onTap: () => showEditDialog(context),
          child: iconImage(
            "assets/icons/pen.png",
            color: const Color.fromARGB(255, 4, 255, 138),
          ),
        ),
      ),
    );
  }

  Image iconImage(String url, {Color color = Colors.white60}) {
    return Image.asset(
      url,
      color: color,
      height: 5.h,
      width: 5.w,
    );
  }

  void showEditDialog(BuildContext context) {
    showBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(255, 0, 34, 53),
        builder: (ctx) {
          return EditDialog(widget: widget, controller: controller);
        });
  }
}
