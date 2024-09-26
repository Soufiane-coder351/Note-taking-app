// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/widgets/button_widget.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class EditScreen extends StatefulWidget {
  static const screenRoute = 'edit_screen';
  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  User signedInUser = _auth.currentUser!;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('Users');

  late String title;
  late String content;
  late String oldTitle;
  late String oldContent;
  late bool intent;

  String utitle = "";
  String ucontent = "";

  List<String> types = ['all', 'work', 'school', 'random'];
  Map<String, bool> added = {
    'all': true,
    'work': false,
    'school': false,
    'random': false,
  };

  void _close() {
    Navigator.pop(context, 'reloaded from edit');
  }

  void _onAddButtonPressed() async {
    if (title.isEmpty || content.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Validation Error',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Please fill in the required fields.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      return;
    }
    try {
      // Get the current user's email
      String userEmail = signedInUser.email!;

      // Find the document reference based on the user's email
      QuerySnapshot querySnapshot = await _usersCollection.where('email', isEqualTo: userEmail).get();
      if (querySnapshot.size == 1) {
        // Get the first (and only) document in the query result
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        for (var key in added.keys) {
          if (added[key] == true) {
            // Update the desired list in the document
            await documentSnapshot.reference.update(
              {
                key: FieldValue.arrayUnion(
                  [
                    {
                      'title': title,
                      'content': content,
                      'time': DateTime.now(),
                    },
                  ],
                ),
              },
            );
          }
        }

        // Show a success message or perform any other action upon successful save
        print('Map added successfully!');
        _close();
      } else {
        // Handle the case where the document is not found or multiple documents are found
        print('Document not found or multiple documents found for the email.');
      }
    } catch (e) {
      // Handle any errors that occur during the save process
      print('Error saving map: $e');
    }
  }

  void _onEditButtonPressed() async {
    print('title : $title');
    print('content : $content');
    if (title.isEmpty || content.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Validation Error',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Please fill in the required fields.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      return;
    }

    try {
      String userEmail = signedInUser.email!;

      QuerySnapshot querySnapshot = await _usersCollection.where('email', isEqualTo: userEmail).get();

      DocumentSnapshot userSnapshot = querySnapshot.docs.first;

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>;

      List<dynamic> allListData = userData['all'];
      List<dynamic> workListData = userData['work'];
      List<dynamic> schoolListData = userData['school'];
      List<dynamic> randomListData = userData['random'];

      await _updateCategoryList(_usersCollection, userSnapshot.id, allListData, 'all', title, content, true);
      await _updateCategoryList(_usersCollection, userSnapshot.id, workListData, 'work', title, content, added['work']!);
      await _updateCategoryList(_usersCollection, userSnapshot.id, schoolListData, 'school', title, content, added['school']!);
      await _updateCategoryList(_usersCollection, userSnapshot.id, randomListData, 'random', title, content, added['random']!);

      Navigator.pop(context);
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> _updateCategoryList(CollectionReference usersCollection, String userId, List<dynamic> categoryListData, String category,
      String newTitle, String newContent, bool wannaAdd) async {
    for (int i = 0; i < categoryListData.length; i++) {
      if (categoryListData[i]['title'] == oldTitle && categoryListData[i]['content'] == oldContent) {
        categoryListData.removeAt(i);
        print('item found');
        break;
      }
    }

    if (wannaAdd) {
      categoryListData.add({
        'title': newTitle,
        'content': newContent,
        'time': DateTime.now(),
      });
    }

    await usersCollection.doc(userId).update({
      category: categoryListData,
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    title = utitle == '' ? args['title'] : utitle;
    content = ucontent == '' ? args['content'] : ucontent;
    intent = args['intent'];

    oldTitle = args['title'];
    oldContent = args['content'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: title,
                    onChanged: (value) {
                      title = value;
                      utitle = value;
                    },
                    style: TextStyle(fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Enter the title...",
                        hintStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Content",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: content,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      content = value;
                      ucontent = value;
                    },
                    style: TextStyle(fontWeight: FontWeight.w600),
                    minLines: 25,
                    maxLines: 25,
                    decoration: InputDecoration(
                        hintText: "Enter the content of the note...",
                        hintStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
              // maybe something here to add image for the future
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  for (int i = 1; i < types.length; i++)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              onPressed: () {
                                setState(() {
                                  if (added[types[i]] == true) {
                                    added[types[i]] = false;
                                  } else {
                                    added[types[i]] = true;
                                  }
                                });
                              },
                              height: 45,
                              backgroundColor: added[types[i]] == true ? Color(0xffffDBA1) : Colors.white,
                              child: Text(
                                types[i],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: i != types.length - 1 ? 10 : 0,
                          )
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      height: 60,
                      backgroundColor: Colors.white,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () async {
                        if (intent == false) {
                          _onAddButtonPressed();
                        } else {
                          _onEditButtonPressed();
                        }
                      },
                      height: 60,
                      backgroundColor: Color(0xffcfff47),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
