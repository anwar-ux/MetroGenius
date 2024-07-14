import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

// ignore: must_be_immutable
class LoginTextfield extends StatelessWidget {
  LoginTextfield({
    super.key,
    required this.hint,
    this.suffix,
    this.validator,
    this.controller,
    this.focusNode,
  });
  String hint;
  Widget? suffix;
  String? Function(String?)? validator;
  TextEditingController? controller;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
         errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        fillColor: AppColors.primaryColor,
        filled: true,
        suffix: suffix,
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w100,
            color: Colors.grey.shade500),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 0.2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
      ),
    );
  }
}
