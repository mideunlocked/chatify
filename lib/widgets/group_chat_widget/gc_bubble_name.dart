import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/user_provider.dart';

class GCBubbleName extends StatelessWidget {
  const GCBubbleName({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder(
        stream: userProvider.getSpecificUser(uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Map<String, dynamic>? userData =
              snapshot.data?.docs.first.data() as Map<String, dynamic>? ?? {};

          return Row(
            children: [
              Text(
                userData["username"] ?? "",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 8.sp,
                ),
              ),
            ],
          );
        });
  }
}
