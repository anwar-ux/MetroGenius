import 'dart:io';

import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
class RegisterPhotoContainer extends StatelessWidget {
  RegisterPhotoContainer({
    this.action,
    this.image,
    super.key,
  });
  void Function()? action;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        Constants.spaceHight10,
        GestureDetector(
          onTap: action,
          child: Container(
            height: 110,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightGrey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image != null?
                Image.file(File(image!)) :
                Icon(
                  Icons.person,
                  size: 20,
                ),
                Constants.spaceHight10,
                Text('Select photo')
              ],
            ),
          ),
        ),
      ],
    );
  }
}