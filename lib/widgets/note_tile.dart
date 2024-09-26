// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  String title;
  String content;
  String time;
  Color color;
  VoidCallback onPressed;

  NoteTile(
      {required this.onPressed,
      required this.color,
      required this.title,
      required this.time,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20, right: 10, top: 10),
              height: 140,
              width: 5,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 20, top: 10),
              
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  height: 140,
                  // width: 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
