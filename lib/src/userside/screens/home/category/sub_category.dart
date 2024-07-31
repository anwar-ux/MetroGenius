import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/userside/screens/home/widgets/all_subcategory.dart';

class SubCategory extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  const SubCategory({super.key, required this.categoryId,required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:  Text(categoryName),
        ),
        body: SubCategoryGrid(
          action: () {},
         
          categoryId: categoryId,
        ));
  }
}