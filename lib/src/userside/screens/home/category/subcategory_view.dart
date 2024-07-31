import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class SubcategoryView extends StatelessWidget {
  final dynamic data;

  SubcategoryView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: true,
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 15),
              title: Text(
                data['Name'],
                style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              background: Image.network(data['Image']),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: data['Checkboxes'].keys.where((key) => data['Checkboxes'][key] == true).map<Widget>((key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: data['Checkboxes'][true] ?? true,
                  onChanged: (bool? value) {
                    // Handle onChanged logic here
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
