import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/add_address.dart';

import 'package:metrogeniusorg/src/userside/screens/profile/bloc/get_address/get_address_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/widgets/profil_small_widget.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAddressBloc()..add(FetchAddresData()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Address'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(AddAddress()));
                },
                icon:Icon(Icons.add))
          ],
        ),
        body: BlocConsumer<GetAddressBloc, GetAddressState>(
          listener: (context, state) {
            if (state is GetAddressFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error fetching addresses')),
              );
            }
          },
          builder: (context, state) {
            if (state is GetAddressLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAddressLoaded) {
              final data = state.data;
              if (data.isEmpty) {
                return const Center(
                  child: Text('No addresses available'),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final doc = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: AppColors.lightGrey)),
                      child: ListTile(
                        title:Text( doc['Name']),
                        subtitle:Text( '${doc['Phone']}\n${doc['Pincode']}\n${doc['HouseOrFlatNo']}, ${doc['Area']}, ${doc['City']}'),
                       
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }
}
