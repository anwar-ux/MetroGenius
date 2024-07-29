import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/register/bloc/employee_job_application_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/getcategory_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';

Future<void> workSelection(BuildContext context, TextEditingController workController) async {
  context.read<GetcategoryBloc>().add(FetchCategoryData());
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocBuilder<GetcategoryBloc, GetcategoryState>(
        builder: (context, state) {
          if (state is GetCategoryLoaded) {
            return ListView.separated(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final doc = state.data[index];
                return ListTile(
                  title: Text(doc['Name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doc['Image']),
                  ),
                  onTap: () {
                    workController.text = doc['Name'];
                    context.read<EmployeeJobApplicationBloc>().add(WorkChanged(workController.text));
                    Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: AppColors.lightGrey,
                  indent: 15,
                  endIndent: 15,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    },
  );
}
