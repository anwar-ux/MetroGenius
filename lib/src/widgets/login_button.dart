import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.title,
    this.action,
  });
  String title;
  void Function()? action;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.thirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
