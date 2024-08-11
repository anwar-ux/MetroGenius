import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class ProfileContainer extends StatelessWidget {
  ProfileContainer({
    this.image,
    this.name,
    this.position,
    super.key,
  });
  String? image;
  String? name;
  String? position;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: image != null ? NetworkImage(image!) : null,
                radius: 60,
                child: image == null ? const Icon(Icons.person) : null,
              ),
              Constants.spaceHight10,
              Text(
                name ?? "username",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1, color: AppColors.lightGrey),
              ),
              Text(
                position??'',
                style: const TextStyle(color: AppColors.lightGrey),
              )
            ],
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
