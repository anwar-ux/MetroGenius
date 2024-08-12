import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/employee_actions/employee_actions_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/get_service_requestes/get_service_request_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/widgets/request_builder.dart';

class RequestedServices extends StatelessWidget {
  const RequestedServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetServiceRequestBloc()..add(FetchRequestData()),
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
                      request_builder(requests, 'Accept',),
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
