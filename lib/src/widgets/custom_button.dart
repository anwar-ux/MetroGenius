import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.action,
    required this.width,
  });
  String title;
  void Function()? action;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.thirdColor, borderRadius: BorderRadius.circular(8)),
      height: 58,
      width: width,
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
