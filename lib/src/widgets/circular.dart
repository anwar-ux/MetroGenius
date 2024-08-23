import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Lottie.asset(
          'assets/loading.json', 
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      );
    },
  );
}
