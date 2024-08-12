import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class customWorkerButton extends StatelessWidget {
   customWorkerButton({
    super.key,
    required this.doc,
    required this.buttonName,
    required this.action,
  });

  final dynamic doc;
  final String buttonName;
  void Function()? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppColors.thirdColor,
        minimumSize: const Size(double.infinity * 0.4, 45),
      ),
      child: Text(
        buttonName,
        style: TextStyle(color: AppColors.seconderyColor),
      ),
    );
  }
}
