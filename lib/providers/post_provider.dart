// import 'package:chatify/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<dynamic> _posts = [];

  List<dynamic> get posts => [..._posts];

  Future<dynamic> addPost(String text) async {
    var currentUser = authInstance.currentUser;
    var uid = currentUser?.uid;

    try {
      await cloudInstance.collection("posts").add(
        {
          "text": text,
          "time": Timestamp.now(),
          "likes": [],
          "postUserInfo": {
            "username": currentUser?.displayName,
            "profileImageUrl": "",
            "userId": uid,
          },
        },
      );

      notifyListeners();
      return true;
    } catch (e) {
      print("Post error: $e");
      return false;
    }
  }

  Future<dynamic> deletePost(
    String id,
  ) async {
    try {
      await cloudInstance.collection("posts").doc(id).delete();

      notifyListeners();
      return true;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  Stream<QuerySnapshot> getPosts() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("posts")
          .orderBy("time", descending: true)
          .snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchPost(String search) async {
    try {
      final querySnapshot = cloudInstance.collection("posts").get();
      // Return the list of filtered documents
      return querySnapshot;
    } catch (error) {
      // Handle the error
      print('Error retrieving filtered posts: $error');
      throw 0;
    }
  }
}
