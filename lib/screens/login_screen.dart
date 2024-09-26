// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/notes_screen.dart';
import 'package:note_app/screens/signup_screen.dart';
import 'package:note_app/widgets/button_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const screenRoute = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSpinning = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isSpinning,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: ListView(
            children: [
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 240,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.asset('images/login.png'),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter your Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xffff6e47),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Color(0xffff6e47),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              ButtonWidget(
                height: 60,
                backgroundColor: Colors.white,
                onPressed: () async {
                  setState(() {
                    isSpinning = true;
                  });
                  
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    Navigator.pushNamed(context, NotesScreen.screenRoute);
                  } catch (e) {
                    print(e);
                  }

                  setState(() {
                    isSpinning = false;
                  });
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.screenRoute);
                },
                child: Text(
                  "Don't have an account? SignUp",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
