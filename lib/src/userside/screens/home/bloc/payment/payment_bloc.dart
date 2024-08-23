import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final UpiIndia upiIndia = UpiIndia();
  PaymentBloc() : super(PaymentInitial()) {
    on<FetchUpiApps>(_onFetchUpiApps);
    on<InitiateUpiPayment>(_onInitiateUpiPayment);
  }

  Future<void> _onFetchUpiApps(FetchUpiApps event, Emitter<PaymentState> emit) async {
    try {
      List<UpiApp> upiApps = await upiIndia.getAllUpiApps();
      print(upiApps);
      emit(UpiAppsLoaded(upiApps));
    } catch (e) {
      emit(UpiPaymentFailure('Failed to fetch UPI apps'));
    }
  }

  Future<void> _onInitiateUpiPayment(InitiateUpiPayment event, Emitter<PaymentState> emit) async {
    emit(UpiPaymentProcessing());

    try {
      UpiResponse response = await upiIndia.startTransaction(
        app: event.upiApp,
        receiverUpiId: event.receiverUpiId,
        transactionRefId: 'TestTransactionRefId',
        transactionNote: event.transactionNote,
        amount: event.amount,
        receiverName: 'Anwar',
      );

      if (response.status == UpiPaymentStatus.SUCCESS) {
        emit(UpiPaymentSuccess(response));
      } else {
        emit(const UpiPaymentFailure('Payment Failed'));
      }
    } catch (e) {
      emit(const UpiPaymentFailure('Failed to initiate payment'));
    }
  }
}
