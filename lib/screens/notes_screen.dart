// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/widgets/button_widget.dart';
import 'package:note_app/widgets/note_list.dart';

class NotesScreen extends StatefulWidget {
  static const screenRoute = 'notes_screen';
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  int activeTab = 0;

  late TabController _tabController;
  List<String> tabs = ["All", "Work", "School", "Random"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleTap(value) {
    setState(() {
      activeTab = value;
    });
    _tabController.animateTo(value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Notes',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    Row(
                      children: [
                        // ButtonWidget(
                        //   onPressed: () {
                        //     Navigator.pushNamed(
                        //         context, SettingsScreen.screenRoute);
                        //   },
                        //   width: 50,
                        //   height: 50,
                        //   backgroundColor: Colors.white,
                        //   child: Icon(
                        //     Icons.settings,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        ButtonWidget(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              EditScreen.screenRoute,
                              arguments: {
                                'title': '',
                                'content': '',
                                'intent': false, //dont edit, but add new
                              },
                            );
                          },
                          width: 50,
                          height: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ButtonWidget(
                          onPressed: () {
                            _auth.signOut();
                            //remove all previous routes and go back to home screen
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false, // remove all previous routes
                            );
                          },
                          width: 50,
                          height: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                padding: EdgeInsets.only(top: 40, bottom: 20),
                indicatorColor: Colors.transparent,
                isScrollable: true,
                onTap: ((value) {
                  handleTap(value);
                }),
                tabs: [
                  for (int i = 0; i < tabs.length; i++)
                    ButtonWidget(
                      onPressed: () {
                        handleTap(i);
                      },
                      height: 50,
                      width: 100,
                      backgroundColor: activeTab == i ? Color(0xffcfff47) : Colors.white,
                      child: Text(
                        tabs[i],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // height: 630,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      NoteList(
                        collectionName: "all",
                      ),
                      NoteList(
                        collectionName: "work",
                      ),
                      NoteList(
                        collectionName: "school",
                      ),
                      NoteList(
                        collectionName: "random",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// testing note examples xD
/*

                        {
                          "title": "Soufiane's fist note",
                          "content": "This is a real note now",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "second",
                          "content": "second note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },
                        {
                          "title": "third",
                          "content": "third note",
                          "time": "Jul 25, 2023"
                        },


*/