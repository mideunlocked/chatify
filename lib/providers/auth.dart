import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<dynamic> createUserEmailAndPassword(
    String email,
    String password,
    String fullName,
    String phoneNumber,
    String username,
    String age,
    bool isAgreed,
  ) async {
    try {
      await authInstance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        cloudInstance.collection("users").doc(value.user?.uid).set({
          "id": value.user?.uid,
          "fullName": fullName,
          "email": email,
          "age": age,
          "phoneNumber": phoneNumber,
          "username": username,
          "isAgree": isAgreed,
        });
        authInstance.currentUser?.updateDisplayName(username);
      });

      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "The account already exists for that email.";
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Sign up error: $e");
      return e.toString();
    }
  }

  Future<dynamic> signInUSer(
    String loginDetail,
    String password,
  ) async {
    try {
      if (loginDetail.contains(".com") != true) {
        QuerySnapshot snap = await cloudInstance
            .collection("users")
            .where("username", isEqualTo: loginDetail)
            .get();

        await authInstance.signInWithEmailAndPassword(
          email: snap.docs[0]["email"],
          password: password,
        );

        notifyListeners();
        return true;
      } else {
        await authInstance.signInWithEmailAndPassword(
          email: loginDetail,
          password: password,
        );

        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email/username.');
        return 'No user found for that email/username.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Sign in error: $e");
      return e;
    }
  }

  Future<dynamic> resetPassword(
    String email,
    bool isSuccess,
  ) async {
    try {
      authInstance.sendPasswordResetEmail(email: email);

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Resest password error: $e");
      return e.toString();
    }
  }
}
