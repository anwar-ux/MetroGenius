part of 'payment_bloc.dart';


abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class UpiAppsLoaded extends PaymentState {
  final List<UpiApp> upiApps;

  const UpiAppsLoaded(this.upiApps);

  @override
  List<Object> get props => [upiApps];
}

class UpiPaymentProcessing extends PaymentState {
  @override
  List<Object> get props => [];
}

class UpiPaymentSuccess extends PaymentState {
  final UpiResponse response;

  const UpiPaymentSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class UpiPaymentFailure extends PaymentState {
  final String error;

  const UpiPaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}
