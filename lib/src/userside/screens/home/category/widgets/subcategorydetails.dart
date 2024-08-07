import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/userside/screens/home/home.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class Subcategorydetails extends StatelessWidget {
  const Subcategorydetails({super.key, required this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppColors.lightGrey,
            ),
            ServiceHeadings(title: 'Price starting from'),
            Constants.spaceHight10,
            Text(
              '₹ ${data['Price'].toString()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Constants.spaceHight20,
            Divider(
              color: AppColors.lightGrey,
            ),
            ServiceHeadings(title: 'Discription'),
            Constants.spaceHight10,
            Text(
              data['Discription'],
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
