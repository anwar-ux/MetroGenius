import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/screens/home/appbar/home_app_bar.dart';
import 'package:metrogeniusorg/src/screens/home/widgets/all_services_grid.dart';
import 'package:metrogeniusorg/src/screens/home/widgets/deal_of_day.dart';
import 'package:metrogeniusorg/src/screens/home/widgets/refer_friend.dart';
import 'package:metrogeniusorg/src/screens/home/widgets/slider_home.dart';
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.spaceHight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Our Services',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const AllServicesGrid(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Constants.spaceHight10,
                  SliderHome(slideItems: slideItems),
                  Constants.spaceHight10,
                  const Text(
                    'Deal of the day',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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

