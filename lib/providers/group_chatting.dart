import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatting with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<GroupChatting> _chats = [];

  Map<String, dynamic> _reply = {
    "text": "",
    "name": "",
    "isMe": "",
  };

  Map<String, dynamic> get reply {
    return {..._reply};
  }

  List<GroupChatting> get chats {
    return [..._chats];
  }

  void replyMessage(
    String name,
    String chatText,
  ) {
    _reply = {
      "name": name,
      "text": chatText,
    };
    notifyListeners();
  }

  void clearReply() {
    _reply = {
      "text": "",
      "name": "",
      "isMe": "",
    };

    notifyListeners();
  }

  Stream<QuerySnapshot> getMessages(List<String> ids) {
    ids.sort();
    String? docId = ids[0].toString() + ids[1].toString();

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("group-chats")
          .doc(docId)
          .collection("messages")
          .orderBy(
            "timeStamp",
            descending: true,
          )
          .snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> getUserGCMessageList() {
    try {
      String? uid = authInstance.currentUser?.uid;

      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("group-chats")
          .orderBy("timeStamp", descending: true)
          .where("recipients", arrayContainsAny: [uid]).snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Future<dynamic> getLastGCMessage(String chatId) async {
    try {
      var result = await cloudInstance
          .collection("group-chats")
          .doc(chatId)
          .collection("messages")
          .orderBy("timeStamp", descending: true)
          .get();

      Map<String, dynamic>? lastChatData = result.docs.first.data();

      return {
        "timeStamp": lastChatData["timeStamp"] ?? Timestamp.now(),
        "text": lastChatData["text"] ?? ""
      };
    } catch (error) {
      print("Get message details error: $error");
      notifyListeners();
      return false;
    }
  }

  Stream<QuerySnapshot> getUnseenMessages(
      String chatId, List<dynamic> recipients) {
    String uid = authInstance.currentUser!.uid;
    recipients.remove(uid);
    print(recipients);

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("group-chats")
          .doc(chatId)
          .collection("messages")
          .where("senderId", isNotEqualTo: uid)
          .where(
            "isSeen",
            whereNotIn: recipients,
          )
          .snapshots();

      return querySnapshot;
    } catch (error) {
      print("Get unseen messages error: $error");
      notifyListeners();
      return const Stream.empty();
    }
  }
}
