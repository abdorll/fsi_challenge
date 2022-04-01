// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';

class Alerts {
  static loadingAlert(context, String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: TextOf('Please wait', 15, FontWeight.w300, black),
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: orange,
                ),
                XSpace(20),
                TextOf("$message...", 18, FontWeight.w400, black)
              ],
            ),
          );
        });
  }

  static errorAlert(context, String message, Function ok) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: TextOf('Request failed', 20, FontWeight.bold, black),
            content: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red.shade300,
                  child: IconOf(Icons.highlight_off_rounded, white, 40),
                ),
                TextOf(message, 20, FontWeight.w200, black)
              ],
            ),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Container(
                  decoration: BoxDecoration(
                      color: green1,
                      border: Border.all(color: green1, width: 1),
                      borderRadius: BorderRadius.circular(90)),
                  child: SideSpace(
                      100, 10, TextOf('Ok', 20, FontWeight.bold, white)),
                ),
                onPressed: () {
                  ok();
                },
              ),
            ],
          );
        });
  }

  static successAlert(context, String message, Function ok) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: TextOf('Request successful', 20, FontWeight.bold, black),
            content: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green.shade500,
                  child: IconOf(Icons.task_alt_rounded, white, 40),
                ),
                TextOf(message, 20, FontWeight.w200, black)
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Container(
                  decoration: BoxDecoration(
                      color: green1,
                      border: Border.all(color: green1, width: 1),
                      borderRadius: BorderRadius.circular(90)),
                  child: SideSpace(
                      100, 10, TextOf('Ok', 20, FontWeight.bold, white)),
                ),
                onPressed: () {
                  ok();
                },
              ),
            ],
          );
        });
    Future.delayed(const Duration(milliseconds: 1000), () {
      ok();
    });
  }

  static responseAlert(context, String message, Function ok) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: TextOf('Hey!', 20, FontWeight.bold, black),
            content: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade400,
                  child: IconOf(Icons.info_outline_rounded, white, 40),
                ),
                TextOf(message, 20, FontWeight.w200, black)
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Container(
                  decoration: BoxDecoration(
                      color: green1,
                      border: Border.all(color: green1, width: 1),
                      borderRadius: BorderRadius.circular(90)),
                  child: SideSpace(
                      100, 10, TextOf('Ok', 20, FontWeight.bold, white)),
                ),
                onPressed: () {
                  ok();
                },
              ),
            ],
          );
        });
  }

  static loadedAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              children: [
                IconOf(Icons.delete_forever, Colors.red, 30),
                YSpace(20),
                TextOf("Error alert", 20, FontWeight.w300, black),
                TextOf(message, 20, FontWeight.w200, black)
              ],
            ),
          );
        });
  }
}
