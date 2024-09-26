// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  double? width;
  double? height;
  Function? onPressed;
  Widget? child;
  Color? backgroundColor = Colors.white;

  ButtonWidget({
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed!();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
