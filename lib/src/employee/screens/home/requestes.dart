import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/home/get_service_requestes/get_service_request_bloc.dart';

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
            if (state is GetRequestLoaded) {
              final data=state.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final doc=data[index];
                  
                  return ListTile(
                    title:Text(doc['Address']) ,
                  );
                },
                itemCount: data.length,
              );
            } else {
              return Center(
                child: Text('No Requests'),
              );
            }
          },
        ),
      ),
    );
  }
}
