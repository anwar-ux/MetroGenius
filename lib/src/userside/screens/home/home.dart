import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/appbar/home_app_bar.dart';
import 'package:metrogeniusorg/src/userside/screens/home/categorys.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/all_services_grid.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/deal_of_day.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/refer_friend.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/slider_home.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> slideItems = [
    'Cleaning',
    'Plumbing',
    'Ac mechanic',
    'Technichen',
    'Slide 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeScreenAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding:const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.spaceHight10,
                  ServiceHeadings(
                    title: 'Our Services',
                    sub: 'ViewAll',
                    action: () => Navigator.of(context).push(createRoute(const UserCategorys())),
                  ),
                ],
              ),
            ),
          ),
          AllServicesGrid(
            icon: Icons.explore_outlined,
            count: 5,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ServiceHeadings(title: 'Popular Services'),
                  Constants.spaceHight10,
                  SliderHome(slideItems: slideItems),
                  Constants.spaceHight10,
                  ServiceHeadings(title: 'Deal of the day'),
                  Constants.spaceHight10,
                  const DealOfTheDay(),
                  Constants.spaceHight15,
                  const ReferFriend(),
                  Constants.spaceHight15,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
class ServiceHeadings extends StatelessWidget {
  ServiceHeadings({
    required this.title,
    this.sub,
    this.action,
    super.key,
  });
  String title;
  String? sub;
  void Function()? action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if(sub!=null)
        GestureDetector(
          onTap:action ,
          child: Container(
            height: 25,
            width: 90,
            decoration: BoxDecoration(
                color: AppColors.thirdColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('ViewAll'),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
