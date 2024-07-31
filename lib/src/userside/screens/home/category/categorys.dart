import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/all_services_grid.dart';

class UserCategorys extends StatelessWidget {
  const UserCategorys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [AllServicesGrid()],
      ),
    );
  }
}
