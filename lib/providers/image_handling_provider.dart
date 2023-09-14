import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageHandlingProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<dynamic> uploadProfileImage(File imageFile, String uid) async {
    try {} catch (e) {
      print("Profile image upload error: $e");
      notifyListeners();
      return false;
    }
  }
}
