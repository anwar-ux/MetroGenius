import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

// ignore: must_be_immutable
class ProfileSmallWidget extends StatelessWidget {
  ProfileSmallWidget(
      {super.key,
      required this.title,
      required this.sub,
      required this.positionTop,
      this.icon});
  String title;
  String sub;
  num positionTop;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * positionTop,
      left: MediaQuery.of(context).size.width * 1 / 20,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
                blurStyle: BlurStyle.normal // changes position of shadow
                ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
            ),
            trailing: Icon(icon),
            subtitle: Text(sub),
          ),
        ),
      ),
    );
  }
}
