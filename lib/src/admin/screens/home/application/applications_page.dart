import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/admin/applications/get_applications.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/applicant_deatils_page.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/bloc/getemployeeapplication/get_employee_applications_bloc.dart';

class ApplicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetEmployeeApplicationsBloc(GetApplications())..add(FetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Applications'),
          centerTitle: true,
        ),
        body: BlocConsumer<GetEmployeeApplicationsBloc,
            GetEmployeeApplicationsState>(
          listener: (context, state) {
            if (state is GetEmployeeApplicationsFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.errorMsg}')),
              );
            }
          },
          builder: (context, state) {
            if (state is GetEmployeeApplicationsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetEmployeeApplicationsLoaded) {
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final doc = data[index];
                  return ListTile(
                    contentPadding: EdgeInsets.only(left: 10, top: 5),
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: FileImage(File(doc['Image'])),
                    ),
                    title: Text(doc['Name']),
                    subtitle: Text(doc['Work']),
                    onTap: () {
                      Navigator.of(context)
                          .push(createRoute( ApplicantDeatilsPage(data:doc,)));
                    },
                  );
                },
              );
            } else {
              return Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}
