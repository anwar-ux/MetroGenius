part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class FetchUpiApps extends PaymentEvent {
  @override
  List<Object> get props => [];
}

class InitiateUpiPayment extends PaymentEvent {
  final UpiApp upiApp;
  final double amount;
  final String receiverUpiId;
  final String transactionNote;

  const InitiateUpiPayment({
    required this.upiApp,
    required this.amount,
    required this.receiverUpiId,
    required this.transactionNote,
  });

  @override
  List<Object> get props => [upiApp, amount, receiverUpiId, transactionNote];
}
