import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/categorys.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/sub_category.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/subcategory_view.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/address_selector.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class BookingDetails extends StatelessWidget {
  final dynamic data;
  final String head;
  final String date;
  final String time;
  final String workType;
  final TextEditingController dateController = TextEditingController();
  final int serviceFee = 50;

  BookingDetails({
    super.key,
    required this.workType,
    required this.data,
    required this.head,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM d, EEEE').format(DateTime.parse(date));
    final String dateTime = '$formattedDate -- $time';

    // Trigger Bloc events once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBookingBloc>().add(DateTimeChanged(dateTime));
      context.read<ServiceBookingBloc>().add(DiscriptionChanged(head));
      context.read<ServiceBookingBloc>().add(ServiceTitleChanged(
            data['Name'],workType
          ));
      context.read<ServiceBookingBloc>().add(TotalPriceChanged(data['Price'] + serviceFee));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(head),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headings('Select your address for service'),
                  Constants.spaceHight10,
                  const AddressSelector(),
                  Constants.spaceHight20,
                  _headings('Selected Date and Time'),
                  Constants.spaceHight10,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(dateTime),
                    ),
                  ),
                  Constants.spaceHight20,
                  _headings('Selected Service'),
                  Constants.spaceHight10,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleAndPrice(title: data['Name'], price: data['Price'].toString()),
                          Text(head),
                        ],
                      ),
                    ),
                  ),
                  Constants.spaceHight20,
                  _headings('Payment Summary'),
                  const Divider(),
                  Constants.spaceHight10,
                  _titleAndPrice(title: 'Item Total', price: data['Price'].toString()),
                  Constants.spaceHight10,
                  _titleAndPrice(title: 'Item Discount', price: 0.toString()),
                  Constants.spaceHight10,
                  _titleAndPrice(title: 'Service Fee', price: serviceFee.toString()),
                  Constants.spaceHight35,
                  _titleAndPrice(title: 'Grand Total', price: state.totalPrice.toString()),
                  Constants.spaceHight35,
                  CustomButton(
                    title: 'Pay',
                    width: double.infinity,
                    action: () {
                      if (state.address.isNotEmpty) {
                        context.read<ServiceBookingBloc>().add(FormSubmit());
                        Navigator.of(context).pushReplacement(createRoute(UserCategorys()));
                      } else {
                        showCustomSnackbar(context, 'Select Address', 'One addres select for providing service', Colors.red);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Text _headings(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.grey,
    ),
  );
}

Row _titleAndPrice({required String title, required String price}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        '₹ $price',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}
