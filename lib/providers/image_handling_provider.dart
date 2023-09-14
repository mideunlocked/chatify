import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageHandlingProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<dynamic> uploadProfileImage(File imageFile) async {
    String? uid = authInstance.currentUser?.uid;

    String path = "user_images/$uid";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      storagePath.delete();

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      await snapshot.ref.getDownloadURL().then((value) {
        authInstance.currentUser?.updatePhotoURL(value);
        cloudInstance.collection("users").doc(uid).update({
          "imageUrl": value,
        });
      });
    } catch (e) {
      print("Profile image upload error: $e");
      notifyListeners();
      return false;
    }
  }

  Future<String> postImage(File imageFile, String postId) async {
    final path = "post_images/$postId";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      final imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print("Post image upload error: $e");
      notifyListeners();
      return "Error";
    }
  }

  Future<String> uploadChatImage(File imageFile, String chatId) async {
    print(chatId);
    final path = "chat_images/$chatId";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      final imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print("Chat image upload error: $e");
      notifyListeners();
      return "Error";
    }
  }

  Future<dynamic> deleteImage(String path) async {
    print(path);
    try {
      await storageInstance.ref().child(path).delete();
    } catch (e) {
      print("Chat image upload error: $e");
      notifyListeners();
      return false;
    }
  }
}
