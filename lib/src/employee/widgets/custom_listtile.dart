import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/utils/colors.dart';

// ignore: camel_case_types
class listTileCustom extends StatelessWidget {
  const listTileCustom({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:const EdgeInsets.all(0),
      leading: Icon(
        icon,
        color: AppColors.primaryColor,
        size: 35,
      ),
      title: Text(title),
      titleTextStyle: GoogleFonts.urbanist(
          color: AppColors.seconderyColor,
          letterSpacing: 1,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      subtitle: Text(subtitle),
      subtitleTextStyle: GoogleFonts.urbanist(
        color: AppColors.seconderyColor,
        letterSpacing: 1,
      ),
    );
  }
}
