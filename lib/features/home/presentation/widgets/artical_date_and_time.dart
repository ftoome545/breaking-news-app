import 'package:flutter/material.dart';

class ArticalDateAndTime extends StatelessWidget {
  const ArticalDateAndTime({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}
