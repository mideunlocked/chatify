import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/group_chat.dart';
import 'image_handling_provider.dart';

class GroupChatting with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<GroupChatting> _groupChats = [];

  Map<String, dynamic> _reply = {
    "text": "",
    "name": "",
    "isMe": "",
  };

  Map<String, dynamic> get reply {
    return {..._reply};
  }

  List<GroupChatting> get groupChats {
    return [..._groupChats];
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

  void initialClearReply() {
    _reply = {
      "text": "",
      "name": "",
      "isMe": "",
    };
  }

  Future<dynamic> createGroupChat(ListGroupChat groupChat) async {
    try {
      var groupChatCollection = cloudInstance.collection("group-chats");
      String? uid = authInstance.currentUser?.uid;
      var groupId = "";

      await groupChatCollection.add({
        "requests": [],
        "about": groupChat.about,
        "recipients": groupChat.recipients,
        "admins": groupChat.admins,
        "timeStamp": Timestamp.now(),
      }).then((value) {
        groupId = value.id;
        var doc = groupChatCollection.doc(value.id);

        doc.update({
          "id": value.id,
        });
        doc.collection("messages").add({
          "timeStamp": Timestamp.now(),
          "senderId": uid,
          "isSeen": [uid],
          "isSent": false,
          "text": groupChat.about["description"] ?? "",
          "imageUrl": "",
          "reply": {
            "name": "",
            "text": "",
          },
        }).then((value) {
          var messagePath =
              groupChatCollection.doc(groupId).collection("messages");
          messagePath.doc(value.id).update({
            "id": value.id,
            "isSent": true,
          });
        });
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Create group chat error: $e");
      notifyListeners();
      return e.toString();
    }
  }

  Future<dynamic> joinGroup(String groupId) async {
    String? uid = authInstance.currentUser?.uid;

    try {
      var groupPath = cloudInstance.collection("group-chats").doc(groupId);

      await groupPath.update({
        "recipients": FieldValue.arrayUnion([uid]),
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Join group error: $e");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> requestJoinGroup(String groupId) async {
    String? uid = authInstance.currentUser?.uid;

    try {
      var groupPath = cloudInstance.collection("group-chats").doc(groupId);

      await groupPath.update({
        "requests": FieldValue.arrayUnion([uid]),
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Request group error: $e");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> acceptRequest(String groupId, String participantId) async {
    try {
      var groupPath = cloudInstance.collection("group-chats").doc(groupId);

      await groupPath.update({
        "recipients": FieldValue.arrayUnion([participantId]),
      }).then((value) {
        groupPath.update({
          "requests": FieldValue.arrayRemove([participantId]),
        });
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Accept request error: $e");
      notifyListeners();
      return e.toString();
    }
  }

  Future<dynamic> removeParticipants(
      String groupId, String participantId) async {
    try {
      var groupPath = cloudInstance.collection("group-chats").doc(groupId);

      await groupPath.update({
        "recipients": FieldValue.arrayRemove([participantId]),
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Remove participants error: $e");
      notifyListeners();
      return e.toString();
    }
  }

  Future<dynamic> updateAdmin(String groupId, String newAdminId) async {
    try {
      var groupPath = cloudInstance.collection("group-chats").doc(groupId);

      await groupPath.update({
        "recipients": [newAdminId],
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Update admin error: $e");
      notifyListeners();
      return e.toString();
    }
  }

  Future<dynamic> sendMessage(
    GroupChat groupChat,
    String gcId,
  ) async {
    try {
      var uid = authInstance.currentUser?.uid;

      var groupChatPath = cloudInstance.collection("group-chats").doc(gcId);
      var messagePath = groupChatPath.collection("messages");

      await messagePath.add({
        "timeStamp": groupChat.timeStamp,
        "senderId": uid,
        "isSeen": [uid],
        "isSent": groupChat.isSent,
        "text": groupChat.text,
        "reply": groupChat.reply,
        "imageUrl": "",
      }).then((value) async {
        if (groupChat.file.existsSync() == true) {
          final imageUrl = await ImageHandlingProvider()
              .uploadChatImage(groupChat.file, value.id);

          messagePath.doc(value.id).update({
            "id": value.id,
            "isSent": true,
            "imageUrl": imageUrl,
          });
        }
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Send group chat error: $e");
      notifyListeners();
      return e.toString();
    }
  }

  Future<dynamic> markMessageAsRead(String chatId, String docId) async {
    String uid = authInstance.currentUser!.uid;

    try {
      await cloudInstance
          .collection("group-chats")
          .doc(chatId)
          .collection("messages")
          .doc(docId)
          .update({
        "isSeen": FieldValue.arrayUnion([uid]),
      }).then((value) {
        print("Done");
      });
    } catch (error) {
      print("Mark as read error: $error");
      notifyListeners();
      return false;
    }
  }

  Stream<QuerySnapshot> getMessages(String docId) {
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
      print("Get group chat error: $e");
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

  Stream<QuerySnapshot> getUnseenMessages(String chatId) {
    String uid = authInstance.currentUser!.uid;

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("group-chats")
          .doc(chatId)
          .collection("messages")
          .where(
            "isSeen",
            arrayContains: uid,
          )
          .snapshots();

      return querySnapshot;
    } catch (error) {
      print("Get unseen messages error: $error");
      notifyListeners();
      return const Stream.empty();
    }
  }

  Future<dynamic> deleteMessage(String id, String chatId) async {
    try {
      var messagePath = cloudInstance
          .collection("group-chats")
          .doc(chatId)
          .collection("messages");

      await messagePath.doc(id).delete().then((value) async {
        await ImageHandlingProvider().deleteImage("chat_images/$id");
      });

      print("Deleted");
      notifyListeners();
      return true;
    } catch (error) {
      print("Delete message error: $error");
      notifyListeners();
      return false;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchGroups(
      String search) async {
    try {
      final querySnapshot = cloudInstance.collection("group-chats").get();
      // Return the list of filtered documents
      return querySnapshot;
    } catch (error) {
      // Handle the error
      print('Error retrieving filtered posts: $error');
      throw 0;
    }
  }
}
