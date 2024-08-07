// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/user/address/address.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(const AddAddressState()) {
    on<NameChanged>(_nameChanged);
    on<PhoneChanged>(_phoneChanged);
    on<PincodeChanged>(_pincodeChanged);
    on<CityChanged>(_cityChanged);
    on<HouseChanged>(_houseChanged);
    on<AreaChanged>(_areaChanged);
    on<FormSubmit>(_formSubmit);
    on<PendingFrom>(_pendingFrom);
  }

  void _nameChanged(NameChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _phoneChanged(PhoneChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _pincodeChanged(PincodeChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(pincode: event.pincode));
  }

  void _cityChanged(CityChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(city: event.city));
  }

  void _houseChanged(HouseChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(houseflatno: event.houseflatno));
  }

  void _areaChanged(AreaChanged event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(area: event.area));
  }

  void _pendingFrom(PendingFrom event, Emitter<AddAddressState> emit) {
    emit(state.copyWith(status: FormStatus.pending));
  }

  void _formSubmit(FormSubmit event, Emitter<AddAddressState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final genaratedId = randomAlphaNumeric(6);
    try {
      final addressDetails = Address.addressInfo(
        id: genaratedId,
        city: state.city,
        name: state.name,
        phone: state.phone,
        houseflatno: state.houseflatno,
        pincode: state.pincode,
        area: state.area,
      );
      final result = await Address.addAddress(addressDetails, genaratedId, userId);
      if (result) {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(status: FormStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
}
