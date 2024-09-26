// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_screen.dart';
import 'package:note_app/widgets/note_tile.dart';
import 'package:intl/intl.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class NoteList extends StatefulWidget {
  String collectionName;

  NoteList({required this.collectionName, super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  User signedInUser = _auth.currentUser!;
  List<Map<String, dynamic>> noteList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Call the function to fetch data when the widget is first initialized
  //   fetchWorkListStream();
  // }

  // Function to fetch the list of maps from Firestore
  Stream<List<Map<String, dynamic>>> fetchWorkListStream() {
    // Replace 'userEmail' with the email of the user you want to retrieve data for
    String userEmail = signedInUser.email!;

    // Get the collection reference for "Users"
    CollectionReference usersCollection = _firestore.collection('Users');

    return usersCollection
        .where('email', isEqualTo: userEmail)
        .snapshots()
        .map((querySnapshot) {
      // Check if the query result is not empty
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document in the query result (assuming the email is unique)
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;

        // Perform a null check before accessing the 'work' property
        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;

          // If the 'work' property exists and is not null, convert each map to a Map<String, dynamic>
          if (userData != null) {
            List<dynamic>? collListData = userData[widget.collectionName];

            if (collListData != null) {
              List<Map<String, dynamic>> tempWorkList = collListData
                  .map((item) => Map<String, dynamic>.from(item))
                  .toList();

              return tempWorkList;
            }
          }
        }
      } else {
        // Handle the case where the user with the specified email is not found
        print('User not found with email: $userEmail');
      }

      // If there's no data or some error occurred, return an empty list
      return [];
    });
  }

  List<Color> colors = [
    Color(0xffffDBA1),
    Color(0xffcfff47),
    Color(0xffd4b4fe),
    Color(0xffff6e47)
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchWorkListStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          noteList = snapshot.data ?? [];
          // Sort the noteList by the "time" property in descending order
          noteList.sort((a, b) => b["time"].compareTo(a["time"]));

          if (noteList.isEmpty) {
            return Text("Nothing to show, press + to add note");
          }

          return ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (context, index) => NoteTile(
              title: noteList[index]["title"]!,
              content: noteList[index]["content"]!,
              time: DateFormat('yyyy-MM-dd').format(
                noteList[index]["time"]!.toDate(),
              ),
              color: colors[index % colors.length],
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  EditScreen.screenRoute,
                  arguments: {
                    'title': noteList[index]["title"]!,
                    'content': noteList[index]["content"]!,
                    'intent': true, // wanna edit
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
