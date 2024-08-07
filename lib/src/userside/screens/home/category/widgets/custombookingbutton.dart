import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class CustomBookingButton extends StatelessWidget {
   CustomBookingButton({
    super.key,
    this.bookAction,
    this.cartAction
  });
void Function()? cartAction;
void Function()? bookAction;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: 'Cart',
              width: MediaQuery.of(context).size.width * 0.45,
              action: cartAction,
            ),
            CustomButton(
              title: 'Book',
              width: MediaQuery.of(context).size.width * 0.45,
              action: bookAction,
            ),
          ],
        ),
      ),
    );
  }
}
