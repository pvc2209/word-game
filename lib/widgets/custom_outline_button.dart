import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
    this.text, {
    Key? key,
    this.onPressed,
    required this.color,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: color),
          primary: color,
        ),
      ),
    );
  }
}
