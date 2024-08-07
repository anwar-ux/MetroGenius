// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/userside/screens/home/appbar/subcategoryappbar.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/bottom_sheet.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/custombookingbutton.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/subcategorydetails.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/usercheckboxes.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class SubcategoryView extends StatelessWidget {
  final dynamic data;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  SubcategoryView({super.key, required this.data});
  String? value;

  @override
  Widget build(BuildContext context) {
    void handleCheckboxChange(String? selectedKey) {
      value = selectedKey;
    }

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SubcategoryViewAppBar(data: data),
              UserCheckBoxes(
                data: data,
                onChanged: handleCheckboxChange,
              ),
              Subcategorydetails(data: data),
            ],
          ),
          CustomBookingButton(
            cartAction: () {},
            bookAction: () {
              if (value != null) {
                bottomSheet(context,data,value!);
              } else {
                showCustomSnackbar(
                  context,
                  'Select a service',
                  '',
                  AppColors.thirdColor,
                );
              }
            },
          ),
         
        ],
      ),
    );
  }
}
