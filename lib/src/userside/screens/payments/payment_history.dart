import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/widgets/app_bar.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Payments'),
      body: const Center(
        child: Text('payments'),
      ),
    );
  }
}
