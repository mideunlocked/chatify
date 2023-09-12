import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageHandlingProvider with ChangeNotifier {
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<dynamic> uploadProfileImage(File imageFile) async {
    User? user = authInstance.currentUser;
    UploadTask uploadTask;

    try {
      final storageRef = storageInstance.ref()
        ..child("user_images")
        ..child("${user?.uid}.png");

      uploadTask = storageRef.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();

      await user?.updatePhotoURL(downloadUrl);
    } catch (e) {
      print("Profile image upload error: $e");
      notifyListeners();
      return false;
    }
  }
}
