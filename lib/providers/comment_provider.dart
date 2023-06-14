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
          "likeCount": [],
          "disLikeCount": [],
          "commenter": {
            "username": authInstance.currentUser?.displayName,
            "profileImageUrl": "",
            "userId": authInstance.currentUser?.uid,
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

  Future<dynamic> likeComment(
      String postId, String commentId, bool isActive) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId);

      if (isActive == false) {
        ref.update({
          "likes": FieldValue.arrayUnion([uid]),
        });
        ref.update({
          "dislikes": FieldValue.arrayRemove([uid]),
        });
      } else {
        ref.update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      }

      notifyListeners();
      return true;
    } catch (error) {
      print("Like error: $error");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> dislikeComment(
      String postId, String commentId, bool isActive) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId);

      if (isActive == false) {
        ref.update({
          "likes": FieldValue.arrayRemove([uid]),
        });
        ref.update({
          "dislikes": FieldValue.arrayUnion([uid]),
        });
      } else {
        ref.update({
          "dislikes": FieldValue.arrayRemove([uid]),
        });
      }

      notifyListeners();
      return true;
    } catch (error) {
      print("Dislike error: $error");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> deleteComment(
    String postId,
    String commentId,
  ) async {
    try {
      await cloudInstance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .delete();

      notifyListeners();
      return true;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }
}
