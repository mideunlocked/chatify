import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'read_by_tile.dart';

class ReadByListContainer extends StatelessWidget {
  const ReadByListContainer({
    super.key,
    required this.readBy,
    required this.cloudInstance,
    required this.divider,
  });

  final List readBy;
  final FirebaseFirestore cloudInstance;
  final Divider divider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: readBy.isEmpty
            ? [
                const Text(
                  "No participant as read your message",
                  textAlign: TextAlign.center,
                ),
              ]
            : readBy.map((id) {
                return FutureBuilder(
                    future: cloudInstance.collection("users").doc(id).get(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      Map<String, dynamic>? data =
                          snapshot.data?.data() as Map<String, dynamic>?;

                      return ReadByTile(
                        username: data?["username"] ?? "xxxxx",
                        divider: divider,
                      );
                    });
              }).toList(),
      ),
    );
  }
}
