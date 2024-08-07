import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/booking_details.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/date_selector.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/time_selector.dart';
import 'package:metrogeniusorg/src/userside/screens/home/home.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

Future<dynamic> bottomSheet(BuildContext context,dynamic data,String head) {
  DateTime? selectedDate;
  String? selectedTime;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceHeadings(title: 'Select Date'),
                  Constants.spaceHight10,
                  DateSelector(
                    onDateSelected: (DateTime value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                  Constants.spaceHight10,
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  Constants.spaceHight10,
                  ServiceHeadings(title: 'Select Time'),
                  Constants.spaceHight10,
                  TimeSelector(
                    onTimeSelected: (String value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                  ),
                  Constants.spaceHight20,
                  const Text(
                    'Please select a date and time for your booking. You can select a date from the next three days and a time slot between 8:00 AM and 6:00 PM. Note that you can only select one time slot per booking.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Constants.spaceHight20,
                  CustomButton(
                    action: () {
                      if (selectedDate != null && selectedTime != null) {
                        Navigator.of(context).push(createRoute(BookingDetails(data: data, head: head)));
                       
                      } else {
                        // Show a message to select both date and time
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select both date and time'),
                          ),
                        );
                      }
                    },
                   title:  'Confirm Booking', width: double.infinity,
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
