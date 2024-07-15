
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/constants.dart';
// ignore: must_be_immutable
class LoginDivider extends StatelessWidget {
  LoginDivider({
    super.key,
    required this.text,
  });

  String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            indent: 10,
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        Constants.spaceWidth10,
        Text(text),
        Constants.spaceWidth10,
        const Expanded(
          child: Divider(
            endIndent: 10,
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
      ],
    );
  }
}
