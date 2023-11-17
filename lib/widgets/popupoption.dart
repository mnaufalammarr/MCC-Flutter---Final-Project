import 'package:flutter/material.dart';

import '../style.dart';

class PopupOption {
  static void alertDialog(context,
      {required String message,
      required VoidCallback onPressedYes,
      required VoidCallback onPressedNo}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              message,
              style: Styles.HeaderText,
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.buttonDefaultBackgroundColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Text("Yes", style: TextStyle(color: Colors.white)),
                onPressed: onPressedYes,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 211, 48, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Text("No", style: TextStyle(color: Colors.white)),
                onPressed: onPressedNo,
              ),
            ],
          );
        });
  }
}
