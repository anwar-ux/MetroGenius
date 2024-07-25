import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/employee/screens/register/register_details_page.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/user_login.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class CommonLoginPage extends StatelessWidget {
  const CommonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CommonLoginContainer(
                action: () => Navigator.of(context).push(createRoute( UserLogin())),
                hight: 150,
                image: 'assets/3069_REpWIFlVTCAxMjItNTA.jpg',
                content: 'To place any type of order\nwith the help of our app',
                title: 'Looking for a Service',
                radius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              Constants.spaceWidth20,
            ],
          ),
          Constants.spaceHight20,
          Row(
            children: [
              Constants.spaceWidth20,
              CommonLoginContainer(
                 action: () => Navigator.of(context).push(createRoute(const RegisterDetailsPage())),
                hight: 150,
                image:
                    'assets/vecteezy_illustration-of-hiring-with-magnifying-glass-in-the-middle_.jpg',
                content: 'Search and apply for jobs in\nyour field of activity',
                title: 'I want to find a job',
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ],
          ),
          Constants.spaceHight20,
          Row(
            children: [
              CommonLoginContainer(
                image:
                    'assets/vecteezy_office-card-creative-icon-design_15054354.jpg',
                hight: 154,
                content: 'This is for the login of\nemployees of MetroGenius',
                title: 'Currently working on\nMetroGenius',
                radius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              Constants.spaceWidth20,
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CommonLoginContainer extends StatelessWidget {
  CommonLoginContainer(
      {super.key,
      required this.content,
      required this.hight,
      required this.title,
      required this.image,
      this.action,
      required this.radius});
  String title;
  String content;
  BorderRadius radius;
  double hight;
  String image;
  void Function()? action;
  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child:GestureDetector(
      onTap:action ,
      child: Container(
          height: hight,
          decoration: BoxDecoration(
            color: AppColors.seconderyColor,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          content,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -25,
                child: SizedBox(
                  height: 150,
                  width: 120,
                  child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
