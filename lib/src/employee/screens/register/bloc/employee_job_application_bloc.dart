import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/employee/registation/employee_jobapllication.dart';
import 'package:random_string/random_string.dart';
part 'employee_job_application_event.dart';
part 'employee_job_application_state.dart';

class EmployeeJobApplicationBloc
    extends Bloc<EmployeeJobApplicationEvent, EmployeeJobApplicationState> {
  EmployeeJobApplicationBloc(this.employeeJobapllication)
      : super(const EmployeeJobApplicationState()) {
    on<PhotoChanged>(_photoChanged);
    on<NameChanged>(_nameChanged);
    on<PhoneChanged>(_phoneChanged);
    on<EmailChanged>(_emailChanged);
    on<WorkChanged>(_workChanged);
    on<ExperienceChanged>(_experienceChanged);
    on<IdproofChanged>(_idproofChanged);
    on<FormSubmit>(_formSubmit);
    on<FormClear>(_formClear);
  }
  final EmployeeJobapllication employeeJobapllication;
  void _photoChanged(
      PhotoChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(image: event.image));
  }

  void _nameChanged(
      NameChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _phoneChanged(
      PhoneChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _emailChanged(
      EmailChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _workChanged(
      WorkChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(work: event.work));
  }
  

  void _experienceChanged(
      ExperienceChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(experience: event.experience));
  }

  void _idproofChanged(
      IdproofChanged event, Emitter<EmployeeJobApplicationState> emit) {
    emit(state.copyWith(iDproof: event.iDproof));
  }

  void _formSubmit(
      FormSubmit event, Emitter<EmployeeJobApplicationState> emit) async {
     emit(state.copyWith(status: FormStatus.pending));
    try {
       final genaratedId = randomAlphaNumeric(6);
      final emplyeeDetails = employeeJobapllication.employeeAplicationInfo(
        id: genaratedId,
        email: state.email,
        name: state.name,
        phone: state.phone,
        iDproof: state.iDproof,
        experience: state.experience,
        work: state.work,
        image: state.image,
      );
      final result =
          await employeeJobapllication.addEmployeeAplication(emplyeeDetails,genaratedId);
         
      if (result) {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(
            status: FormStatus.error, errorMsg: 'Applicaton submition failed'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }

  void _formClear(EmployeeJobApplicationEvent event,
      Emitter<EmployeeJobApplicationState> emit) {
    emit(EmployeeJobApplicationState.initial());
    
  }
}
