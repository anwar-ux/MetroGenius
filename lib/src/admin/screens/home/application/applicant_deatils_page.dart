import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class ApplicantDeatilsPage extends StatelessWidget {
  final data;
  const ApplicantDeatilsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              MainTopLeftContainer(
                image: data['Image'],
              ),
              MainTopRightContainer(
                email: data['Email'],
                number: data['Phone'],
                work: data['Work'],
                experience: data['Experience'],
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                color: AppColors.thirdColor,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.1,
                color: AppColors.seconderyColor,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MainTopRightContainer extends StatelessWidget {
  MainTopRightContainer({
    required this.email,
    required this.number,
    required this.work,
    required this.experience,
    super.key,
  });
  String work;
  int number;
  String email;
  int experience;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.4,
      color: AppColors.seconderyColor,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Position applied',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Constants.spaceHight10,
            Text(
              work,
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, color: AppColors.thirdColor),
            ),
            Constants.spaceHight20,
            Text(
              'Contact Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Constants.spaceHight10,
            Text(
              number.toString(),
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, color: AppColors.thirdColor),
            ),
            Constants.spaceHight20,
            Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Constants.spaceHight10,
            Text(
              email,
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, color: AppColors.thirdColor),
            ),
            Constants.spaceHight20,
            Text(
              'Work Experience',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Constants.spaceHight10,
            Text(
              experience.toString(),
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, color: AppColors.thirdColor),
            ),
          ],
        ),
      ),
    );
  }
}

class MainTopLeftContainer extends StatelessWidget {
  MainTopLeftContainer({
    required this.image,
    super.key,
  });
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: AppColors.thirdColor.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.seconderyColor),
            child: CircleAvatar(
              backgroundImage: FileImage(File(image)),
              radius: 20,
            ),
          ),
          Constants.spaceHight10,
          const Text(
            'name',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}
