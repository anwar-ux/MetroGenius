  import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: AppColors.seconderyColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/istockphoto-1305268276-612x612.jpg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}