part of 'service_booking_bloc.dart';

sealed class ServiceBookingEvent {}

final class AddressChanged extends ServiceBookingEvent {
  AddressChanged(this.address);
  final String address;
}

final class DateTimeChanged extends ServiceBookingEvent {
  DateTimeChanged(this.dateTime);
  final String dateTime;
}

final class DiscountPriceChanged extends ServiceBookingEvent {
  DiscountPriceChanged(this.discountPrice);
  final int discountPrice;
}

final class DiscriptionChanged extends ServiceBookingEvent {
  DiscriptionChanged(this.discription);
  final String discription;
}

final class ServiceTitleChanged extends ServiceBookingEvent {
  ServiceTitleChanged(this.serviceTitle,this.workType);
  final String serviceTitle;
  final String workType;
}

final class TotalPriceChanged extends ServiceBookingEvent {
  TotalPriceChanged(this.totalPrice);
  final int totalPrice;
}

final class FormSubmit extends ServiceBookingEvent {}
