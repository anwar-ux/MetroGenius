import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/user/booking/service_booking.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'service_booking_event.dart';
part 'service_booking_state.dart';

class ServiceBookingBloc extends Bloc<ServiceBookingEvent, ServiceBookingState> {
  ServiceBookingBloc() : super(const ServiceBookingState()) {
    on<AddressChanged>(_addressChanged);
    on<DateTimeChanged>(_dateTimeChanged);
    on<DiscountPriceChanged>(_discountPriceChanged);
    on<TotalPriceChanged>(_totalPriceChanged);
    on<DiscriptionChanged>(_discriptionChanged);
    on<ServiceTitleChanged>(_serviceTitleChanged);
    on<FormSubmit>(_formSubmit);
    on<PaymentTypeChanged>(_paymentTypeChanged);
  }

  void _addressChanged(AddressChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(address: event.address, userName: event.userName));
  }

  void _paymentTypeChanged(PaymentTypeChanged event, Emitter<ServiceBookingState> emit) {
    print(event.paymentType);
    emit(state.copyWith(paymentType: event.paymentType));
  }

  void _dateTimeChanged(DateTimeChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(dateTime: event.dateTime));
  }

  void _serviceTitleChanged(ServiceTitleChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(serviceTitle: event.serviceTitle, workType: event.workType));
  }

  void _discountPriceChanged(DiscountPriceChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(discountPrice: event.discountPrice));
  }

  void _totalPriceChanged(TotalPriceChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(totalPrice: event.totalPrice));
  }

  void _discriptionChanged(DiscriptionChanged event, Emitter<ServiceBookingState> emit) {
    emit(state.copyWith(discription: event.discription));
  }

  Future<void> _formSubmit(FormSubmit event, Emitter<ServiceBookingState> emit) async {
    emit(state.copyWith(status: FormStatus.pending));
    try {
      final genaratedId = randomAlphaNumeric(6);
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final requestDetails = ServiceBooking.requestInfo(
        id: genaratedId,
        userName: state.userName,
        workType: state.workType,
        userId: userId!,
        address: state.address,
        dateTime: state.dateTime,
        serviceTitle: state.serviceTitle,
        totalPrice: state.totalPrice,
        discountPrice: state.discountPrice,
        workerId: '',
        paymentType: state.paymentType,
        requestStatus: RequestStatus.pending.toString(),
        discription: state.discription,
      );
      print(requestDetails);
      if (requestDetails.isNotEmpty) {
        final result = await ServiceBooking.submitServiceRequest(userId, requestDetails, genaratedId);
        if (result) {
          emit(state.copyWith(status: FormStatus.success));
        } else {
          emit(state.copyWith(status: FormStatus.error, errorMsg: 'Submission failed'));
        }
      } else {
        emit(state.copyWith(status: FormStatus.error, errorMsg: 'userId is null'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
}
