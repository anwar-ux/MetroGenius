import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/userside/screens/home/appbar/appbar_overlay.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor:AppColors.primaryColor,
      automaticallyImplyLeading: false,
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace:  FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 15),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CURRENT LOCATION',
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                  color: Colors.grey),
            ),
            Text(
              'MARADU,ERNAKULAM',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.grey),
            )
          ],
        ),
        background: AppBarOverlay(),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(10.0),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(Icons.notifications_active_outlined,color: AppColors.lightGrey,),
        )
      ],
    );
  }
}

