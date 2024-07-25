import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/employee/screens/register/job_application_page.dart';
import 'package:metrogeniusorg/src/employee/widgets/background_container.dart';
import 'package:metrogeniusorg/src/employee/widgets/custom_listtile.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class RegisterDetailsPage extends StatelessWidget {
  const RegisterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundContainer(
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.75)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BECOME A WORKER WITH US?',
                    style: TextStyle(
                      color: AppColors.seconderyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 1,
                    ),
                  ),
                  const Text(
                    'Join Our Workforce Today',
                    style: TextStyle(
                      color: AppColors.seconderyColor,
                      letterSpacing: 1,
                    ),
                  ),
                  Constants.spaceHight50,
                  const listTileCustom(
                    title: 'Increased Job Opportunities',
                    subtitle:
                        'Expand your client base and enjoy flexible working hours',
                    icon: Icons.timelapse,
                  ),
                  Constants.spaceHight20,
                  const listTileCustom(
                    title: 'Enhanced Professional Reputation',
                    subtitle:
                        'Build credibility through user reviews and showcase your work',
                    icon: Icons.badge,
                  ),
                  Constants.spaceHight20,
                  const listTileCustom(
                    title: 'Convenient Business Management',
                    subtitle:
                        'Enjoy a hassle-free payment process, withsecure and direct earnings deposited into youraccount',
                    icon: Icons.wallet,
                  ),
                  Constants.spaceHight50,
                  CustomButton(
                      title: 'Register',
                      action: () => Navigator.of(context)
                          .push(createRoute(JobApplicationPage())))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
