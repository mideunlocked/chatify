import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChat {
  final String id;
  final String senderId;
  final Timestamp timeStamp;
  final bool isSent;
  final String text;
  final File file;
  final List<dynamic> isSeen;
  final Map<String, dynamic> reply;

  const GroupChat({
    required this.id,
    required this.file,
    required this.senderId,
    required this.timeStamp,
    required this.reply,
    required this.isSeen,
    required this.isSent,
    required this.text,
  });
}

class GroupChatForScreen {
  final String id;
  final String senderId;
  final Timestamp timeStamp;
  final bool isSent;
  final String text;
  final String file;
  final List<dynamic> isSeen;
  final Map<String, dynamic> reply;

  const GroupChatForScreen({
    required this.id,
    required this.file,
    required this.senderId,
    required this.timeStamp,
    required this.reply,
    required this.isSeen,
    required this.isSent,
    required this.text,
  });
}

class ListGroupChat {
  final Map<String, dynamic> about;
  final List<dynamic> recipients;
  final List<dynamic> requests;
  final List<GroupChatForScreen> chats;
  final List<dynamic> admins;
  final Timestamp timestamp;
  final String id;

  const ListGroupChat({
    required this.requests,
    required this.id,
    required this.about,
    required this.recipients,
    required this.chats,
    required this.admins,
    required this.timestamp,
  });
}
