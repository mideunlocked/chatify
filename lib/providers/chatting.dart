import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';

class Chatting with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<Chat> _chats = [];

  Map<String, dynamic> _reply = {
    "text": "",
    "name": "",
    "isMe": "",
  };

  Map<String, dynamic> get reply {
    return {..._reply};
  }

  List<Chat> get chats {
    return [..._chats];
  }

  Future<dynamic> senMessage(
    Chat chat,
    String chatId,
    String recieverUid,
  ) async {
    try {
      var uid = authInstance.currentUser?.uid;
      var ids = [recieverUid, uid];
      ids.sort();
      print(ids);
      String? docId = ids[0].toString() + ids[1].toString();

      var chatPath = cloudInstance.collection("chats").doc(docId);
      var messagePath = chatPath.collection("messages");

      await chatPath.set({
        "recipients": [recieverUid, uid],
        "timeStamp": Timestamp.now(),
      });

      await messagePath.add({
        "timeStamp": chat.timeStamp,
        "senderId": uid,
        "isSeen": chat.isSeen,
        "isSent": chat.isSent,
        "text": chat.text,
        "reply": chat.reply,
      }).then((value) {
        messagePath.doc(value.id).update({
          "id": value.id,
          "isSent": true,
        });
      });

      notifyListeners();
      return true;
    } catch (error) {
      print("Send chat error: $error");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> startChat(String recieverUid, Chat chat) async {
    var uid = authInstance.currentUser?.uid;

    try {
      var ids = [recieverUid, uid];
      ids.sort();
      print(ids);
      String? docId = ids[0].toString() + ids[1].toString();

      var chatPath = cloudInstance.collection("chats").doc(docId);

      await chatPath.set({
        "recipients": [recieverUid, uid],
        "timeStamp": Timestamp.now(),
      });
      var chatResult = await chatPath.collection("messages").add({
        "timeStamp": chat.timeStamp,
        "senderId": uid,
        "isSeen": chat.isSeen,
        "isSent": chat.isSent,
        "text": chat.text,
        "reply": chat.reply,
      });

      await chatPath.collection("messages").doc(chatResult.id).update({
        "id": chatResult.id,
        "isSent": true,
      });

      print("done");
      notifyListeners();
      return true;
    } catch (error) {
      print("Send chat error: $error");
      notifyListeners();
      return false;
    }
  }

  Stream<QuerySnapshot> getMessages(List<String> ids) {
    ids.sort();
    String? docId = ids[0].toString() + ids[1].toString();

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("chats")
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

  Stream<QuerySnapshot> getUserMessageList() {
    try {
      String? uid = authInstance.currentUser?.uid;

      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("chats")
          .orderBy("timeStamp", descending: true)
          .where("recipients", arrayContainsAny: [uid]).snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> getUnseenMessages(String chatId, String reciverUid) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .where("senderId", isEqualTo: reciverUid)
          .where("isSeen", isEqualTo: false)
          .snapshots();

      return querySnapshot;
    } catch (error) {
      print("Get unseen messages error: $error");
      notifyListeners();
      return const Stream.empty();
    }
  }

  Future<dynamic> markMessageAsRead(String chatId, String docId) async {
    try {
      await cloudInstance
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .doc(docId)
          .update({
        "isSeen": true,
      }).then((value) {
        print("Done");
      });
    } catch (error) {
      print("Mark as read error: $error");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> getLastMessageDetails(String chatId) async {
    try {
      var result = await cloudInstance
          .collection("chats")
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

  Future<dynamic> deleteMessage(String id, String chatId) async {
    try {
      var messagePath =
          cloudInstance.collection("chats").doc(chatId).collection("messages");

      await messagePath.doc(id).delete();

      notifyListeners();
      return true;
    } catch (error) {
      print("Delete message error: $error");
      notifyListeners();
      return false;
    }
  }
}
