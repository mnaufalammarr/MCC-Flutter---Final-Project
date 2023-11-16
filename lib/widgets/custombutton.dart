import 'package:flutter/material.dart';

import '../style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Size? minimumsize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.minimumsize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: Styles.buttonDefaultTextStyle,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Styles.buttonDefaultBackgroundColor,
        minimumSize: minimumsize,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
