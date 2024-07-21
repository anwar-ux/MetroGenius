import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:metrogeniusorg/services/admin/applications/get_applications.dart';

part 'accept_reject_event.dart';
part 'accept_reject_state.dart';

class AcceptRejectBloc extends Bloc<AcceptRejectEvent, AcceptRejectState> {
  AcceptRejectBloc() : super(const AcceptRejectState()) {
    on<AcceptClicked>(_acceptClicked);
    on<RejectClicked>(_rejectClicked);
  }

  void _acceptClicked(
      AcceptClicked event, Emitter<AcceptRejectState> emit) async {
    emit(state.copyWith(acceptStatus: FormStatusAccept.initial));
    try {
      final employeeDoc = Applications.employeeAplicationInfo(event.data);
      final acceptStatus =
          await Applications.addEmployee(employeeDoc, employeeDoc['Id']);
      if (acceptStatus) {
        emit(state.copyWith(acceptStatus: FormStatusAccept.success));
      }
    } catch (e) {
      emit(state.copyWith(acceptStatus: FormStatusAccept.error));
    }
  }

  void _rejectClicked(
      RejectClicked event, Emitter<AcceptRejectState> emit) async {
    emit(state.copyWith(rejectStatus: FormStatusReject.pending));
    try {
      final deletestatus = await Applications.deleteCategory(event.id);
      if (deletestatus) {
        emit(state.copyWith(rejectStatus: FormStatusReject.success));
      }
    } catch (e) {
      emit(state.copyWith(rejectStatus: FormStatusReject.error));
    }
  }
}
