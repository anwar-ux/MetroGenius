part of 'add_address_bloc.dart';

sealed class AddAddressEvent {}

final class AreaChanged extends AddAddressEvent {
  AreaChanged(this.area);
  final String area;
}
final class NameChanged extends AddAddressEvent {
  NameChanged(this.name);
  final String name;
}
final class PhoneChanged extends AddAddressEvent {
  PhoneChanged(this.phone);
  final int phone;
}
final class CityChanged extends AddAddressEvent {
  CityChanged(this.city);
  final String city;
}
final class PincodeChanged extends AddAddressEvent {
  PincodeChanged(this.pincode);
  final int pincode;
}
final class HouseChanged extends AddAddressEvent {
  HouseChanged(this.houseflatno);
  final String houseflatno;
}

final class FormSubmit extends AddAddressEvent {}
final class PendingFrom extends AddAddressEvent {}

final class FormClear extends AddAddressEvent {}

