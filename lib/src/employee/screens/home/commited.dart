import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/employee_actions/employee_actions_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/get_service_requestes/get_service_request_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/widgets/custom_worker_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class CommitedServices extends StatelessWidget {
  const CommitedServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetServiceRequestBloc()..add(FetchCommitedRequestData()),
        child: BlocConsumer<GetServiceRequestBloc, GetServiceRequestState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetRequestLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetRequestLoaded) {
              final data = state.data;

              // Group requests by date
              final Map<String, List<DocumentSnapshot>> groupedData = {};

              for (var doc in data) {
                final Timestamp timestamp = doc['CreatAt'];
                final DateTime dateTime = timestamp.toDate();
                final String formattedDate = DateFormat('dd-MM-yyyy EEEE').format(dateTime);

                if (!groupedData.containsKey(formattedDate)) {
                  groupedData[formattedDate] = [];
                }
                groupedData[formattedDate]?.add(doc);
              }

              return ListView.builder(
                itemCount: groupedData.length,
                itemBuilder: (context, groupIndex) {
                  final String date = groupedData.keys.elementAt(groupIndex);
                  final List<DocumentSnapshot> requests = groupedData[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date, // Display the date as the header
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
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
                                          buttonName: 'Completed',
                                          action: () {
                                            context.read<EmployeeActionsBloc>().add(CompletedClicked(doc['Id']));
                                          }),   
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No Requests'),
              );
            }
          },
        ),
      ),
    );
  }
}
