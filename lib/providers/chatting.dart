import 'package:flutter/material.dart';

import '../models/chat.dart';

class Chatting with ChangeNotifier {
  List<Chat> _chats = [
    Chat(
      id: "q",
      timeStamp: 1,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "Hi",
    ),
    Chat(
      id: "w",
      timeStamp: 2,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "This is seun",
    ),
    Chat(
      id: "e",
      timeStamp: 3,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "Good day seun",
    ),
    Chat(
      id: "r",
      timeStamp: 4,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "I'm Ariyo",
    ),
    Chat(
      id: "t",
      timeStamp: 5,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "Nice to meet you",
    ),
    Chat(
      id: "y",
      timeStamp: 6,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "And you too",
    ),
    Chat(
      id: "q",
      timeStamp: 1,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "Hi",
    ),
    Chat(
      id: "w",
      timeStamp: 2,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "This is seun",
    ),
    Chat(
      id: "e",
      timeStamp: 3,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "Good day seun",
    ),
    Chat(
      id: "r",
      timeStamp: 4,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "I'm Ariyo",
    ),
    Chat(
      id: "t",
      timeStamp: 5,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "Nice to meet you",
    ),
    Chat(
      id: "y",
      timeStamp: 6,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text:
          "And you too, I'm doing well, i'm guessing you are the uber driver i requested for?",
    ),
    Chat(
      id: "e",
      timeStamp: 3,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "Good day seun",
    ),
    Chat(
      id: "r",
      timeStamp: 4,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text: "I'm Ariyo",
    ),
    Chat(
      id: "t",
      timeStamp: 5,
      reply: {},
      isMe: false,
      isSeen: true,
      isSent: true,
      text: "Nice to meet you",
    ),
    Chat(
      id: "y",
      timeStamp: 6,
      reply: {},
      isMe: true,
      isSeen: true,
      isSent: true,
      text:
          "And you too, I'm doing well, i'm guessing you are the uber driver i requested for?",
    ),
  ];

  Map<String, dynamic> _reply = {};

  Map<String, dynamic> get reply {
    return {..._reply};
  }

  List<Chat> get chats {
    return [..._chats];
  }

  void senMessage(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }

  List<Chat> getMessages() {
    notifyListeners();
    return chats;
  }

  void replyMessage(String name, String chatText, int index) {
    _reply = {
      "index": index,
      "name": name,
      "text": chatText,
    };
    notifyListeners();
  }

  void clearReply() {
    _reply = {};
    notifyListeners();
  }

  void deleteMessage(String id) {
    _chats.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
