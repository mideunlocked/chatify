import 'package:flutter/material.dart';

class ParticipantActionListTile extends StatelessWidget {
  const ParticipantActionListTile({
    super.key,
    required this.data,
    required this.function,
    required this.icon,
    required this.iconColor,
    required this.admins,
  });

  final Map<String, dynamic>? data;
  final List<dynamic> admins;
  final Function function;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    bool isAdmin = admins.contains(data?["id"] ?? "");

    return ListTile(
      title: Text("@${data?["username"] ?? ""}"),
      subtitle: Text(
        data?["fullName"] ?? "",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white54,
            ),
      ),
      trailing: InkWell(
        onTap: () {
          if (isAdmin != true) {
            function();
          }
        },
        child: Icon(
          isAdmin ? Icons.verified_user_rounded : icon,
          color: isAdmin ? Colors.grey : iconColor,
        ),
      ),
    );
  }
}
