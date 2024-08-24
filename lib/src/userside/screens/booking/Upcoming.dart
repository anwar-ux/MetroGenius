import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/userside/screens/booking/bloc/getuser_request/get_user_request_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/booking/widgets/request_list_builder.dart';
 
class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetUserRequestBloc()..add(FetchUserPendingRequestData()),
        child: BlocConsumer<GetUserRequestBloc, GetUserRequestState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetUserRequestLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetUserRequestLoaded) {
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
                itemBuilder: (context, groupIndex) {
                  final String date = groupedData.keys.elementAt(groupIndex);
                  final List<DocumentSnapshot> requests = groupedData[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                      RequestListBuilder(requests: requests)
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
