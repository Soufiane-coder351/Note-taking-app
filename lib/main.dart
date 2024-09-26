// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/notes_screen.dart';
import 'package:note_app/screens/settings_screen.dart';
import 'package:note_app/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        fontFamily: 'Mont'
      ),
      initialRoute: _auth.currentUser != null ? NotesScreen.screenRoute : HomeScreen.screenRoute,
      routes: {
        HomeScreen.screenRoute :(context) => HomeScreen(),
        SignupScreen.screenRoute :(context) => SignupScreen(),
        LoginScreen.screenRoute :(context) => LoginScreen(),
        NotesScreen.screenRoute :(context) => NotesScreen(),
        EditScreen.screenRoute :(context) => EditScreen(),
        SettingsScreen.screenRoute :(context) => SettingsScreen()
      },
    );
  }
}

