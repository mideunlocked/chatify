// import 'package:chatify/models/comment.dart';
import 'package:chatify/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<Comment> _comments = [];

  List<Comment> get comments => [..._comments];

  Future<dynamic> addComment(String comment, String id) async {
    try {
      await cloudInstance
          .collection("posts")
          .doc(id)
          .collection("comments")
          .add(
        {
          "comment": comment,
          "time": Timestamp.now(),
          "likeCount": 0,
          "disLikeCount": 0,
          "commenter": {
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

  Future<dynamic> deleteComments(
    String id,
  ) async {
    String uid = authInstance.currentUser!.uid;
    try {
      await cloudInstance
          .collection("posts")
          .doc(id)
          .collection("comments")
          .doc(uid)
          .delete();

      notifyListeners();
      return true;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  Stream<QuerySnapshot> getComments(String id) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("posts")
          .doc(id)
          .collection("comments")
          .orderBy("time", descending: true)
          .snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Future<dynamic> likeComments(
      String postId, int newLikeCount, String id) async {
    String uid = authInstance.currentUser!.uid;

    try {
      await cloudInstance
          .collection("posts")
          .doc(id)
          .collection("comments")
          .doc(postId)
          .set(
        {
          "likeCount": newLikeCount,
        },
        SetOptions(
          merge: true,
        ),
      ).then((_) async {
        await cloudInstance
            .collection("comments")
            .doc(postId)
            .collection("whoLiked")
            .doc(uid)
            .update({
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

  Future<dynamic> disLikeComments(
    String postId,
    int newLikeCount,
    String id,
  ) async {
    String uid = authInstance.currentUser!.uid;

    try {
      await cloudInstance
          .collection("posts")
          .doc(id)
          .collection("comments")
          .doc(postId)
          .set(
        {
          "likeCount": newLikeCount,
        },
        SetOptions(
          merge: true,
        ),
      ).then((_) async {
        await cloudInstance
            .collection("comments")
            .doc(postId)
            .collection("whoLiked")
            .doc(uid)
            .delete();
      });

      notifyListeners();
      return true;
    } catch (e) {
      print("Like error: $e");
      return e.toString();
    }
  }
}
