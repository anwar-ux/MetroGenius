// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/admin/applications/get_applications.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/applicant_deatils_page.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/bloc/getemployeeapplication/get_employee_applications_bloc.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetEmployeeApplicationsBloc(Applications())..add(FetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Applications'),
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetEmployeeApplicationsLoaded) {
              if (state.data.isEmpty) {
                const Center(
                  child: Text(
                    'There is no applications',
                  ),
                );
              }
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final doc = data[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 10, top: 5),
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(doc['Image']),
                    ),
                    title: Text(doc['Name']),
                    subtitle: Text(doc['Work']),
                    onTap: () {
                      Navigator.of(context).push(
                        createRoute(
                          ApplicantDeatilsPage(
                            data: doc,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}
