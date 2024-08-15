import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                itemBuilder: (context, index) {
                  final String date = groupedData.keys.elementAt(index);
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
                              date, // Use the date string as the header
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      request_builder(requests, 'Accept'),
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
