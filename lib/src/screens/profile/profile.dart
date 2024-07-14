import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/screens/profile/profil_small_widget.dart';
import 'package:metrogeniusorg/src/screens/profile/profile_main_widget.dart';
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
