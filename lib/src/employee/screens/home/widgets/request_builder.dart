import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/employee_actions/employee_actions_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/widgets/custom_worker_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';


// ignore: non_constant_identifier_names
ListView request_builder(List<dynamic> requests, String buttonName) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: requests.length,
    itemBuilder: (context, index) {
      final doc = requests[index];
      final Timestamp time = doc['CreatAt'];
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
                blurStyle: BlurStyle.normal,
              ),
            ],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(doc['UserName']),
                  Text(
                    DateFormat('hh:mm a').format(time.toDate()),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service : ${doc['ServiceTitle']} | ${doc['Discription']}',
                  ),
                  Text('Address : ${doc['Address']}'),
                  Text('${doc['DateTime']}'),
                  Constants.spaceHight10,
                  customWorkerButton(
                    doc: doc,
                    buttonName: buttonName,
                    action: () {
                        context.read<EmployeeActionsBloc>().add(AcceptClicked(doc['Id']));
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
