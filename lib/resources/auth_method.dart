import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/userData.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> registerUser({
    required String email,
    required String name,
    required String password,
    required String cardInfo,
  }) async {
    String resp = "Some Error occurred";
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          password.isNotEmpty ||
          cardInfo.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserData userData = UserData(
          Email: email,
          Name: name,
          userId: cred.user!.uid,
          cardInfo: cardInfo,
        );

        await _fireStore.collection('User').doc(cred.user!.uid).set(
              userData.toJson(),
            );
        resp = 'success';
      }
    } catch (err) {
      print(err);
      resp = err.toString();
    }
    return resp;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
