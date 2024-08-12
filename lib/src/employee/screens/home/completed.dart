import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/get_service_requestes/get_service_request_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class CompletedServices extends StatelessWidget {
  const CompletedServices({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetServiceRequestBloc()..add(FetchCompletedRequestData()),
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

              final today = DateTime.now();
              final yesterday = today.subtract(const Duration(days: 1));
              final todayRequests = [];
              final yesterdayRequests = [];
              final earlierRequests = [];

              for (var doc in data) {
                final Timestamp timestamp = doc['CreatAt'];
                final DateTime dateTime = timestamp.toDate();
                if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(today)) {
                  todayRequests.add(doc);
                } else if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(yesterday)) {
                  yesterdayRequests.add(doc);
                } else {
                  earlierRequests.add(doc);
                }
              }

              final groupedData = [
                {'label': 'Today', 'data': todayRequests},
                {'label': 'Yesterday', 'data': yesterdayRequests},
                {'label': 'Earlier', 'data': earlierRequests},
              ];

              return ListView.builder(
                itemCount: groupedData.length,
                itemBuilder: (context, groupIndex) {
                  final group = groupedData[groupIndex];
                  final label = group['label'];
                  final requests = group['data'] as List;

                  if (requests.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label.toString(),
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
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
