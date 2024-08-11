import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:metrogeniusorg/src/employee/screens/home/employee_home.dart';
import 'package:metrogeniusorg/src/employee/screens/profile/employee_profile.dart';
import 'package:metrogeniusorg/src/employee/screens/schedule/Employee_schedule.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class EmployeeBottomNavigation extends StatefulWidget {
  const EmployeeBottomNavigation({super.key});

  @override
  State<EmployeeBottomNavigation> createState() => _EmployeeBottomNavigationState();
}

class _EmployeeBottomNavigationState extends State<EmployeeBottomNavigation> {
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  int _currentIndex = 0;
  final List<Widget> _children = [
    EmployeeHome(),
    EmployeeSchedule(),
    const EmployeeProfile(),

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
              height: isVisible ? kBottomNavigationBarHeight + 22 : 0,
              child: isVisible ? child : const SizedBox.shrink(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: AppColors.seconderyColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GNav(
                haptic: true,
                tabBackgroundColor: AppColors.thirdColor,
                activeColor: AppColors.seconderyColor,
                gap: 8,
                color: AppColors.thirdColor,
                hoverColor: Colors.green,
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                   GButton(
                    icon: Icons.schedule,
                    text: 'Schedules',
                  ),
                  GButton(
                    icon: Icons.person_2_rounded,
                    text: 'Profile',
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
