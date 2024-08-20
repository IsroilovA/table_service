import 'package:flutter/material.dart';

class DrawerHeaderText extends StatelessWidget {
  const DrawerHeaderText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
    );
  }
}
