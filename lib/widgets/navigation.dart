// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Navigation {
  static withReturn(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static withNoReturn(context, Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static previous(
    context,
  ) {
    Navigator.pop(context);
  }
}

class PreviousPageIcon extends StatelessWidget {
  Color color;
  double size;
  PreviousPageIcon(this.color, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color,
          size: size,
        ));
  }
}

class XSpace extends StatelessWidget {
  XSpace(this.width, {Key? key}) : super(key: key);
  double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class YSpace extends StatelessWidget {
  YSpace(this.height, {Key? key}) : super(key: key);
  double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
