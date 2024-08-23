import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/payment/payment_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bottom_navigation.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';

import 'package:upi_india/upi_app.dart';

class PaymentBottomSheet {
  static Future<void> showPaymentOptions({
    required BuildContext context,
    required String receiverUpiId,
    required double amount,
    required String transactionNote,
  }) async {
    Object? selectedOption; // Variable to store the selected option (either UpiApp or COD)

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => PaymentBloc()..add(FetchUpiApps()),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select payment method',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding: const EdgeInsetsDirectional.all(0),
                        leading: const Icon(Icons.payments_outlined),
                        title: const Text('Cash on Service'),
                        selected: selectedOption == 'COD',
                        onTap: () {
                          setState(() {
                            selectedOption = 'COD';
                            context.read<ServiceBookingBloc>().add(PaymentTypeChanged('Cash on Service'));
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      BlocListener<PaymentBloc, PaymentState>(
                        listener: (context, state) {
                          if (state is UpiPaymentSuccess) {
                            context.read<ServiceBookingBloc>().add(PaymentTypeChanged('Completed'));
                            context.read<ServiceBookingBloc>().add(FormSubmit());
                            Navigator.of(context).push(createRoute(const UserBottomNavigation()));
                            _showBookingConfirmedDialog(context);
                          } else if (state is UpiPaymentFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('')),
                            );
                          }
                        },
                        child: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, state) {
                            if (state is UpiAppsLoaded) {
                              return Column(
                                children: [
                                  ...state.upiApps.map((UpiApp app) {
                                    return ListTile(
                                      contentPadding: const EdgeInsetsDirectional.all(0),
                                      leading: Image.memory(app.icon, height: 40, width: 40),
                                      title: Text(app.name),
                                      selected: selectedOption == app,
                                      onTap: () {
                                        setState(() {
                                          selectedOption = app; // Update the selected option to the UPI app
                                          context.read<ServiceBookingBloc>().add(PaymentTypeChanged('Completed'));
                                        });
                                      },
                                    );
                                  }).toList(),
                                ],
                              );
                            } else if (state is UpiPaymentProcessing) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return const Center(
                                child: Text('Loading UPI apps...'),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: 'Proceed',
                        width: double.infinity,
                        action: selectedOption != null
                            ? () {
                                if (selectedOption == 'COD') {
                                  
                                  context.read<ServiceBookingBloc>().add(FormSubmit());
                                  Navigator.of(context).push(createRoute(const UserBottomNavigation()));

                                  _showBookingConfirmedDialog(context);
                                } else if (selectedOption is UpiApp) {
                                  context.read<PaymentBloc>().add(
                                        InitiateUpiPayment(
                                          upiApp: selectedOption as UpiApp,
                                          amount: amount,
                                          receiverUpiId: receiverUpiId,
                                          transactionNote: transactionNote,
                                        ),
                                      );
                                }
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

static void _showBookingConfirmedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor: AppColors.seconderyColor,
               content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/Animation - 1724411699820.json', 
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
             Center(child: Text('Your booking has been successfully confirmed.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          ],
        ),
        actions: [
         CustomButton(title: 'Ok', width: double.infinity,action: () => Navigator.pop(context),)
        ],
      );
    },
  );
}
}
