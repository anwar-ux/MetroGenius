part of 'add_address_bloc.dart';

enum FormStatus {
  initial,
  pending,
  success,
  error,
}

@immutable
class AddAddressState {
  const AddAddressState({
    this.name = '',
    this.phone = 0,
    this.houseflatno = '',
    this.pincode = 0,
    this.status = FormStatus.initial,
    this.city = '',
    this.area = '',
    this.errorMsg,
  });

  final String name;
  final FormStatus status;
  final String? errorMsg;
  final int phone;
  final String houseflatno;
  final int pincode;
  final String city;
  final String area;

  AddAddressState copyWith({
    String? name,
    FormStatus? status,
    String? errorMsg,
    String? houseflatno,
    int? phone,
    int? pincode,
    String? area,
    String? city,
  }) =>
      AddAddressState(
          name: name ?? this.name,
          area: area??this.area,
          city: city??this.city,
          status: status ?? this.status,
          errorMsg: errorMsg ?? this.errorMsg,
          houseflatno: houseflatno ?? this.houseflatno,
          phone: phone ?? this.phone,
          pincode: pincode ?? this.pincode);

  factory AddAddressState.initial() {
    return const AddAddressState();
  }
}

final class EmployeeJobApplicationLoding extends AddAddressState {}
