import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/user/registation/google_auth_service.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/user_signin/user_signin_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/getstart/common_login_page.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/address.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/widgets/profil_small_widget.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/widgets/profile_main_widget.dart';
import 'package:metrogeniusorg/src/widgets/alertdialog_custom.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ProfileContainer(),
          ProfileSmallWidget(
            action: () => Navigator.of(context).push(createRoute(Address())),
            positionTop: 0.30,
            title: 'Address',
            sub: 'chundattu(H),cheruvattoor,kothamang....',
            icon: Icons.edit_location_alt,
          ),
          Constants.spaceHight10,
          ProfileSmallWidget(
            positionTop: 0.425,
            title: 'User details',
            sub: 'Edit your details',
            icon: Icons.edit_document,
          ),
          Constants.spaceHight10,
          ProfileSmallWidget(
            positionTop: 0.55,
            title: 'Invite friends',
            sub: 'Invite users from your connection',
            icon: Icons.person_add,
          ),
          Constants.spaceHight10,
          ProfileSmallWidget(
            positionTop: 0.675,
            title: 'Setting',
            sub: 'App settings',
            icon: Icons.settings,
          ),
          Constants.spaceHight10,
          ProfileSmallWidget(
            action: () {
              alertDialogCustom(
                context: context,
                title: 'Logout',
                message: 'Are you sure you want to log out?',
                firstButtonText: 'Cancel',
                secondButtonText: 'Logout',
                firstButtonAction: () {
                  Navigator.of(context).pop();
                },
                secondButtonAction: () {
                  context.read<UserSigninBloc>().add(UserLoggedOut());
                  GoogleAuthService.signOutWithGoogle();
                  Navigator.of(context)
                      .pushReplacement(createRoute(const CommonLoginPage()));
                },
              );
            },
            positionTop: 0.80,
            title: 'Log out',
            sub: 'Logout from this account',
            icon: Icons.logout,
          ),
          Constants.spaceHight40
        ],
      ),
    );
  }
}
