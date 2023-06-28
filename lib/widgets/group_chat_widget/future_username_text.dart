import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FutureUsernameText extends StatelessWidget {
  const FutureUsernameText({
    super.key,
    required this.textStyle,
    required this.keyString,
    required this.uid,
  });

  final TextStyle textStyle;
  final String keyString;
  final String uid;

  @override
  Widget build(BuildContext context) {
    var cloudInstance = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
        future: cloudInstance.collection("users").doc(uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Map<String, dynamic>? data =
              snapshot.data?.data() as Map<String, dynamic>?;

          return Text(
            "$keyString: @${data?["username"] ?? "xxxx"}",
            style: textStyle,
          );
        });
  }
}
