import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class BookingDetails extends StatelessWidget {
  final dynamic data;
  final String head;
  final TextEditingController dateController = TextEditingController();
 

  BookingDetails({super.key, required this.data, required this.head});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(head),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your address for service',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Constants.spaceHight10,
            Flexible(
              child: Container(
                
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.thirdColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Constants.spaceHight10,
                      // CustomTextfield(
                      //   readOnly: true,
                      //   controller: dateController,
                      //   hint: dateFormat.format(DateTime.now()), 
                      //   suffix:const Icon(Icons.calendar_month),
                      //   onTapSuffix: () {
                         
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
