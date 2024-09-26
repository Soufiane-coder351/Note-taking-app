// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/widgets/button_widget.dart';

class SettingsScreen extends StatefulWidget {
  static const screenRoute = "settings_screen";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Still in development...",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white,
                height: 60,
                width: double.infinity,
                child: Text(
                  "Return ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
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
