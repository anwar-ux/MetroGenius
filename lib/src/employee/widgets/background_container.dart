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
        child: Image.network(
          'https://media.istockphoto.com/id/1305268276/vector/registration-abstract-concept-vector-illustration.jpg?s=612x612&w=0&k=20&c=nfvUbHjcNDVIPdWkaxGx0z0WZaAEuBK9SyG-aIqg2-0=',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}