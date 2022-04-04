import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({
    Key? key,
    required this.char,
    required this.onTap,
  }) : super(key: key);

  final String char;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            char,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
