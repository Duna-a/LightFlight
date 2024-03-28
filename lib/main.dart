// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    // Replace with your actual Firebase project configuration
  final firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAspkUJ_FrWCRiIZ_gq8EXbAB3yNUUw7WI",
    appId: "1:519520418458:android:377e038a9eabbf58debd23",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    projectId: "lightflight-7abd4",
  );
  await Firebase.initializeApp(options: firebaseConfig);

  // **Temporary User Injection (for development/testing only):**
  // **Remove this code before deploying to production!**
  final userService = UserService();
  await userService.createUser(name: 'Test User2');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(), // Use a custom app widget for better organization
    theme: ThemeData(
      // Your theme customizations
      primaryColor: Color(0xFF2F83C5),
      primaryColorLight: Color(0xFF1BAEC6),
      primaryColorDark: Color(0xFF096499),
      highlightColor: Color(0xFF48C4DD),
      scaffoldBackgroundColor: Color(0xFFF3F9FB),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF096499), fontSize: 16),
        bodyMedium: TextStyle(color: Color(0xFF096499), fontSize: 14),
        bodySmall: TextStyle(color: Color(0xFF2F83C5), fontSize: 12),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F9FB),
      body: SafeArea(
        child: Container(
          // ... your welcome page layout (consider using separate widgets)
        ),
      ),
    );
  }
}

class UserService { // Separate class for user operations
  Future<void> createUser({required String name}) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('User').doc('user6'); // Use auto-generated document ID
      final json = {'name': name};
      await docUser.set(json);
      print('User created successfully (temporary injection)');
    } catch (error) {
      print('Error creating user: $error');
      // Implement error handling here
    }
  }
}
