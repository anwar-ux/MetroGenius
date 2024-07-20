import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:metrogeniusorg/src/admin/screens/category/category_page.dart';
import 'package:metrogeniusorg/src/admin/screens/home/home.dart';
import 'package:metrogeniusorg/src/admin/screens/workers/workers_page.dart';
import 'package:metrogeniusorg/src/userside/screens/booking/booking.dart';
import 'package:metrogeniusorg/src/userside/screens/home/home.dart';
import 'package:metrogeniusorg/src/userside/screens/payments/payment_history.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/profile.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminBottomNavigation> {
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  int _currentIndex = 0;
  final List<Widget> _children = [
    const AdminHome(),
    const CategoryPage(),
    const WorkersPage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              bottomNavBarVisible.value = false;
            } else if (notification.direction == ScrollDirection.forward) {
              bottomNavBarVisible.value = true;
            }
            return true;
          },
          child: _children[_currentIndex],
        ),
        bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bottomNavBarVisible,
          builder: (context, isVisible, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isVisible ? kBottomNavigationBarHeight + 12 : 0,
              child: isVisible ? child : const SizedBox.shrink(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: AppColors.seconderyColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: GNav(
                haptic: true,
                tabBackgroundColor: AppColors.thirdColor,
                activeColor: AppColors.seconderyColor,
                gap: 8,
                color: AppColors.thirdColor,
                hoverColor: Colors.green,
                padding: const EdgeInsets.all(14),
                tabs: const [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.category,
                    text: 'Category',
                  ),
                  GButton(
                    icon: Icons.work_outline_outlined,
                    text: 'Workers',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: onTabTapped,
              ),
            ),
          ),
        ));
  }
}