// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/screens/signup_screen.dart';
import 'package:note_app/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  static const screenRoute = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcfff47),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' the\n best\n app\n for\n your\n notes',
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900]),
              ),
              ButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.screenRoute);
                },
                width: double.infinity,
                backgroundColor: Colors.white,
                height: 60,
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
