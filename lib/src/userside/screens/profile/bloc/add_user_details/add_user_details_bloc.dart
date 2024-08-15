import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/user/user_details/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_user_details_event.dart';
part 'add_user_details_state.dart';

class AddUserDetailsBloc extends Bloc<AddUserDetailsEvent, AddUserDetailsState> {
  AddUserDetailsBloc() : super(const AddUserDetailsState()) {
    on<NameChanged>(_nameChanged);
    on<PhotoChanged>(_photoChanged);
    on<FormSubmit>(_formSubmit);
    on<PendingFrom>(_pendingFrom);
  }

  void _nameChanged(NameChanged event, Emitter<AddUserDetailsState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _photoChanged(PhotoChanged event, Emitter<AddUserDetailsState> emit) {
    emit(state.copyWith(image: event.photo));
  }

  void _pendingFrom(PendingFrom event, Emitter<AddUserDetailsState> emit) {
    emit(state.copyWith(status: FormStatus.pending));
  }

  void _formSubmit(FormSubmit event, Emitter<AddUserDetailsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final details = UserDetails.userInfo(name: state.name, image: state.image);
      final result = await UserDetails.addUserDetails(details, userId,);
      if (result) {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(status: FormStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, ));
    }
  }
}
