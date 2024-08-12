import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/add_address.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/bloc/get_address/get_address_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({super.key});

  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String? selectedAddressId;
  bool showAllAddresses = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetAddressBloc>().add(FetchAddresData());
    });

    return BlocConsumer<GetAddressBloc, GetAddressState>(
      listener: (context, state) {
        if (state is GetAddressFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
        }
      },
      builder: (context, state) {
        if (state is GetAddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetAddressLoaded) {
          final addresses = state.data;
          final visibleAddresses = showAllAddresses ? addresses : addresses.take(1).toList();

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...visibleAddresses.map((address) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: selectedAddressId == address.id
                          ? const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            )
                          : const Icon(Icons.location_on_outlined),
                      title: Text(address['Name'] ?? 'Unnamed Address',
                          style: TextStyle(fontWeight: selectedAddressId == address.id ? FontWeight.bold : FontWeight.normal)),
                      subtitle: Text(
                        '${address['HouseOrFlatNo']}, ${address['Area']}, ${address['City']}, ${address['Pincode']}, ${address['Phone']}',
                        style: TextStyle(fontWeight: selectedAddressId == address.id ? FontWeight.bold : FontWeight.normal),
                      ),
                      onTap: () {
                        final oneline =
                            '${address['HouseOrFlatNo']}, ${address['Area']}, ${address['City']}, ${address['Pincode']}, ${address['Phone']}';
                        context.read<ServiceBookingBloc>().add(AddressChanged(oneline,address['Name']));
                        setState(() {
                          selectedAddressId = address.id;
                        });
                      },
                    );
                  }),
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(createRoute(AddAddress()));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add new address'),
                      ),
                      if (!showAllAddresses && addresses.length > 1)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showAllAddresses = true;
                            });
                          },
                          child: const Text('More'),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return const Text('No address found');
      },
    );
  }
}
