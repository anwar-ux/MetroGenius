import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/services/user/saved/saved_request.dart';
import 'package:metrogeniusorg/src/userside/screens/home/appbar/subcategoryappbar.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/savedservices/saved_services_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/bottom_sheet.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/custombookingbutton.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/subcategorydetails.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/usercheckboxes.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class SubcategoryView extends StatefulWidget {
  final dynamic data;
  final String workType;

  const SubcategoryView({Key? key, required this.data, required this.workType}) : super(key: key);

  @override
  _SubcategoryViewState createState() => _SubcategoryViewState();
}

class _SubcategoryViewState extends State<SubcategoryView> {
  String? value;
  bool serviceIsSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfServiceIsSaved();
  }

  void _checkIfServiceIsSaved() async {
    final isSaved = await SavedService.isServiceSaved(widget.data['Id']);
    setState(() {
      serviceIsSaved = isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SubcategoryViewAppBar(data: widget.data),
              UserCheckBoxes(
                data: widget.data,
                onChanged: (selectedKey) {
                  value = selectedKey;
                },
              ),
              Subcategorydetails(data: widget.data),
            ],
          ),
          CustomBookingButton(
            saveName: serviceIsSaved ? 'Unsave' : 'Save',
            cartAction: () async {
              if (serviceIsSaved) {
                context.read<SavedServicesBloc>().add(RemoveFromSaved(widget.data['Id']));
              } else {
                 context.read<SavedServicesBloc>().add(AddToSave(widget.data));
              }
              _checkIfServiceIsSaved(); 
            },
            bookAction: () {
              if (value != null) {
                bottomSheet(context, widget.data, value!, widget.workType);
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
