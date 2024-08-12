import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/employee/login.dart/login.dart';

part 'employee_login_event.dart';
part 'employee_login_state.dart';

class EmployeeLoginBloc extends Bloc<EmployeeLoginEvent, EmployeeLoginState> {
  EmployeeLoginBloc() : super(const EmployeeLoginState()) {
     on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmit>(_formSubmit);
    on<UserLoggedOut>(_userLoggedOut);
  }



  void _emailChanged(EmailChanged event, Emitter<EmployeeLoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<EmployeeLoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _formSubmit(
      FormSubmit event, Emitter<EmployeeLoginState> emit) async {
    emit(state.copyWith(status: FormStatus.pending));
    try {
      final user = await LoginEmployee.loginEmployee(
        state.email,
        state.password,
      );
      if (user) {
       

        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(
            status: FormStatus.error, errorMsg: 'Sign in failed.'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
   void _userLoggedOut(UserLoggedOut event, Emitter<EmployeeLoginState> emit) async {
    emit(EmployeeLoginState.initial());
  }
}

