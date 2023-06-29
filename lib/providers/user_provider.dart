import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final Map<String, dynamic> _user = {};

  Map<String, dynamic> get user => {..._user};

  Stream<QuerySnapshot> getUser() {
    String uid = authInstance.currentUser!.uid;
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("users")
          .where("id", isEqualTo: uid)
          .snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> getSpecificUser(String uid) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = cloudInstance
          .collection("users")
          .where("id", isEqualTo: uid)
          .snapshots();

      return querySnapshot;
    } catch (e) {
      print("Get posts error: $e");
      return const Stream.empty();
    }
  }

  Future<dynamic> updateUser(String key, String value) async {
    String uid = authInstance.currentUser!.uid;
    print(uid);

    try {
      cloudInstance.collection("users").doc(uid).update({
        key: value,
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("Update user error: $e");
      return e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers() async {
    try {
      final querySnapshot = cloudInstance.collection("users").get();
      // Return the list of filtered documents
      return querySnapshot;
    } catch (error) {
      // Handle the error
      print('Error retrieving filtered posts: $error');
      throw 0;
    }
  }
}
