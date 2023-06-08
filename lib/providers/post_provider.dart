// import 'package:chatify/models/comment.dart';
import 'package:chatify/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  final List<Post> _post = [];

  List<Post> get post => [
        ..._post,
      ];

  Future<dynamic> addPost(String text) async {
    try {
      await cloudInstance.collection("posts").add(
        {
          "text": text,
          "time": Timestamp.now(),
          "likes": [],
          "postUserInfo": {
            "username": "johndoe",
            "profileImageUrl": "",
            "userId": "12345",
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
    int index,
  ) async {
    try {
      await cloudInstance.collection("posts").doc(id).delete();

      _post.removeAt(index);
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

  Future<dynamic> likePost(
    String postId,
  ) async {
    try {
      await cloudInstance.collection("posts").doc(postId).set(
        {
          "likeCount": "",
        },
        SetOptions(
          merge: true,
        ),
      ).then((_) async {
        await cloudInstance
            .collection("posts")
            .doc(postId)
            .collection("whoLiked")
            .add({
          "userId": "12345",
        });
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Like error: $e");
      return e.toString();
    }
  }

  Future<dynamic> searchPost(String search) async {
    try {
      final querySnapshot = cloudInstance
          .collection("posts")
          .where(
            "text",
            isEqualTo: search,
          )
          .get();
      notifyListeners();
      // Return the list of filtered documents
      return querySnapshot;
    } catch (error) {
      // Handle the error
      print('Error retrieving filtered posts: $error');
      return false;
    }
  }
}
