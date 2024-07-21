import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class MainTopLeftContainer extends StatelessWidget {
  MainTopLeftContainer({
    required this.image,
    required this.name,
    this.accept,
    this.delete,
    super.key,
  });
  String image;
  String name;
  void Function()? delete;
    void Function()? accept;
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
              backgroundImage: NetworkImage(image),
              radius: 20,
            ),
          ),
          Constants.spaceHight10,
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Constants.spaceHight40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: delete, child: const Text('Reject')),
              ElevatedButton(onPressed:accept , child: const Text('Accept')),
            ],
          )
        ],
      ),
    );
  }
}
