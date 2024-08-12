import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/employee/getemployee/employee.dart';

part 'employee_actions_event.dart';
part 'employee_actions_state.dart';

class EmployeeActionsBloc extends Bloc<EmployeeActionsEvent, EmployeeActionsState> {
  EmployeeActionsBloc() : super(const EmployeeActionsState()) {
    on<AcceptClicked>(_acceptClicked);
    on<RejectClicked>(_rejectClicked);
    on<CompletedClicked>(_completedClicked);
  }

  void _acceptClicked(AcceptClicked event, Emitter<EmployeeActionsState> emit) async {
    try {
      final acceptStatus = await EmployeeService.onAccept(id: event.id);

      emit(state.copyWith(acceptStatus: FormStatus.pending));

      if (acceptStatus) {
        emit(state.copyWith(acceptStatus: FormStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(
        acceptStatus: FormStatus.error,
      ));
    }
  }

  void _completedClicked(CompletedClicked event, Emitter<EmployeeActionsState> emit) async {
    try {
      final acceptStatus = await EmployeeService.onComplete(id: event.id);

      emit(state.copyWith(completed: FormStatus.pending));

      if (acceptStatus) {
        emit(state.copyWith(completed: FormStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(
        completed: FormStatus.error,
      ));
    }
  }
  void _rejectClicked(RejectClicked event, Emitter<EmployeeActionsState> emit) async {
    emit(state.copyWith(rejectStatus: FormStatus.pending));
    try {
     
    } catch (e) {
      print('Error in _rejectClicked: $e');
      emit(state.copyWith(rejectStatus: FormStatus.error));
    }
  }
}
