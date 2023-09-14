import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ListChat {
  final List<Chat> chats;
  final String reciverUid;
  final Timestamp time;

  const ListChat({
    required this.chats,
    required this.reciverUid,
    required this.time,
  });
}

class Chat {
  final String id;
  final Timestamp timeStamp;
  final bool isMe;
  final bool isSeen;
  final bool isSent;
  final String text;
  final File file;
  final Map<String, dynamic> reply;

  const Chat({
    required this.id,
    required this.timeStamp,
    required this.reply,
    required this.isMe,
    required this.isSeen,
    required this.isSent,
    required this.text,
    required this.file,
  });
}
